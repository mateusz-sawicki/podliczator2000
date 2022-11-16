import 'package:flutter/material.dart';
import 'package:podliczator2000/model/summary_period.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_category_chart.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_data_table.dart';
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
    if (provider.period == SummaryPeriod.any) {
      return await provider.getCategoriesSummary(provider.focusedDay);
    }
    return await provider.getCategoriesSummary(provider.focusedDay);
  }

  @override
  void initState() {
    super.initState();
    _getSummaryList();
    _getCategorySummaryList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var summaryList = db.summaries;
        return summaryList.isNotEmpty
            ? Column(
                children: [
                  SummaryTotal(
                    summarySum: countSums(summaryList),
                  ),
                  const Flexible(flex: 1, child: SummaryCategoryChart()),
                  Expanded(
                    child: SummaryDataTable(
                      summaryList: summaryList,
                    ),
                  ),
                ],
              )
            : const Center(child: EmptySummary());
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
