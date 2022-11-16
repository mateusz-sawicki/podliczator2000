import 'package:flutter/material.dart';
import 'package:podliczator2000/model/summary_period.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_fetcher.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Podsumowanie'),
            elevation: 0,
            bottom: TabBar(
              labelPadding: EdgeInsets.zero,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  color: Colors.grey[50]),
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
                  text: 'Dowolne',
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
                SummaryFetcher(period: SummaryPeriod.any),
              ]),
        ));
  }
}
