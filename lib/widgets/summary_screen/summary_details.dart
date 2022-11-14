import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_data_table.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_total.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../../model/summary.dart';

class SummaryDetails extends StatefulWidget {
  const SummaryDetails({super.key});

  @override
  State<SummaryDetails> createState() => _SummaryDetailsState();
}

class _SummaryDetailsState extends State<SummaryDetails> {
  late Future _summaryList;

  Future _getSummaryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.getSummary(provider.focusedDay);
  }

  @override
  void initState() {
    super.initState();
    _summaryList = _getSummaryList();
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
                  Expanded(
                    child: SummaryDataTable(
                      summaryList: summaryList,
                    ),
                  ),
                ],
              )
            : const Center(child: Text("PUSTE PODSUMOWANIE"));
      },
    );
  }

  String countSums(List<Summary> list) {
    double sum = 0;
    for (var element in list) {
      sum += element.procedureSum;
    }
    return sum.toStringAsFixed(2);
  }
}
