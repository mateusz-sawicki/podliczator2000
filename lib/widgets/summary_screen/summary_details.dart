import 'package:flutter/material.dart';
import 'package:podliczator2000/model/summary_period.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_chart_card.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_data_table.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_date.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_total.dart';
import 'package:provider/provider.dart';
import '../../model/summary.dart';
import 'empty_summary.dart';

class SummaryDetails extends StatefulWidget {
  const SummaryDetails({super.key});

  @override
  State<SummaryDetails> createState() => _SummaryDetailsState();
}

class _SummaryDetailsState extends State<SummaryDetails> {
  Future _getSummaryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.getSummary(provider.focusedDay);
  }

  Future _getCategorySummaryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    if (provider.period == SummaryPeriod.yearly) {
      return await provider.getCategoriesSummary(provider.focusedDay);
    }
    return await provider.getCategoriesSummary(provider.focusedDay);
  }

  Future _setPickedDate() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      return provider.pickedDate = provider.focusedDay;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSummaryList();
    _getCategorySummaryList();
    _setPickedDate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var summaryList = db.summaries;
        return summaryList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(child: SummaryDate()),
                    SliverToBoxAdapter(
                      child: SummaryTotal(summarySum: countSums(summaryList)),
                    ),
                    const SliverToBoxAdapter(
                      child: SummaryChartCard(),
                    ),
                    SliverToBoxAdapter(
                      child: SummaryDataTable(
                        summaryList: summaryList,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    Expanded(flex: 8, child: SummaryDate()),
                    Expanded(flex: 92, child: EmptySummary()),
                  ],
                ),
              );
      },
    );
  }

  double countSums(List<Summary> list) {
    double sum = 0;
    for (var element in list) {
      sum += element.procedureSum;
    }
    return sum;
  }
}
