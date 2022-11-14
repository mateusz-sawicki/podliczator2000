import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class SummaryCategoryChart extends StatefulWidget {
  const SummaryCategoryChart({super.key});

  @override
  State<SummaryCategoryChart> createState() => _SummaryCategoryChartState();
}

class _SummaryCategoryChartState extends State<SummaryCategoryChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<DatabaseProvider>(builder: (_, db, __) {
        var list = db.categorySummaries;
        var total = db.calculateTotalCategories();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Procedury: "),
            ),
            Center(
                child: Text(total.toStringAsFixed(0),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ))),
            Expanded(
              child: Row(children: [
                Expanded(
                  flex: 40,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 30.0,
                      sections: total != 0
                          ? list
                              .map(
                                (e) => PieChartSectionData(
                                  radius: 20,
                                  showTitle: false,
                                  value: double.parse(
                                      e.categoryEntries.toString()),
                                  color: Colors.primaries[list.indexOf(e)],
                                ),
                              )
                              .toList()
                          : list
                              .map(
                                (e) => PieChartSectionData(
                                  showTitle: false,
                                  color: Colors.primaries[list.indexOf(e)],
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
                Expanded(
                    flex: 65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...list.map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Container(
                                    width: 8.0,
                                    height: 8.0,
                                    color: Colors.primaries[list.indexOf(e)],
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    "${e.categoryName} [${e.categoryEntries.toString()}]",
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(total == 0
                                      ? '0%'
                                      : '${((e.categoryEntries / total) * 100).toStringAsFixed(2)}%'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
            ),
          ],
        );
      }),
    );
  }
}
