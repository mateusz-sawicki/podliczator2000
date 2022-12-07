import 'package:flutter/material.dart';
import 'package:podliczator2000/api/raport_service.dart';
import 'package:podliczator2000/model/summary_period.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_fetcher.dart';
import 'package:provider/provider.dart';

import '../provider/database_provider.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final PdfRaportService service = PdfRaportService();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    final snackbar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.warning_amber,
            color: Colors.orange[800],
          ),
          const SizedBox(width: 10),
          const Text('Brak procedur w podsumowaniu'),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.orange,
      duration: const Duration(milliseconds: 1000),
    );

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: const Text('Podsumowanie'),
            elevation: 0,
            actions: [
              Consumer<DatabaseProvider>(builder: (_, db, __) {
                var summaryList = db.summaries;
                return summaryList.isNotEmpty
                    ? IconButton(
                        onPressed: () async {
                          final data = await service.createRaport(
                              summaryList,
                              provider.setDates(
                                  provider.period, provider.pickedDate),
                              provider.period);
                          service.savePdfFile("raport_test", data);
                        },
                        icon: const Icon(Icons.picture_as_pdf))
                    : IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                        icon: const Icon(Icons.picture_as_pdf));
              })
            ],
            bottom: TabBar(
              labelPadding: EdgeInsets.zero,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  color: Colors.grey[300]),
              tabs: const [
                Tab(
                  text: 'Dzienne',
                ),
                Tab(
                  text: 'Tygodniowe',
                ),
                Tab(
                  text: 'Miesięczne',
                ),
                Tab(
                  text: 'Roczne',
                )
              ],
            ),
          ),
          body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                SummaryFetcher(period: SummaryPeriod.daily),
                SummaryFetcher(period: SummaryPeriod.weekly),
                SummaryFetcher(period: SummaryPeriod.monthly),
                SummaryFetcher(period: SummaryPeriod.yearly),
              ]),
        ));
  }
}
