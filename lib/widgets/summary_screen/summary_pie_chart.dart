import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:podliczator2000/model/category_summary.dart';

class SummaryPieChart extends StatelessWidget {
  const SummaryPieChart({
    Key? key,
    required this.total,
    required this.list,
  }) : super(key: key);

  final double total;
  final List<CategorySummary> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          width: double.infinity,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 30.0,
              sectionsSpace: 1,
              sections: total != 0
                  ? list
                      .map(
                        (e) => PieChartSectionData(
                          radius: 20,
                          showTitle: false,
                          value: double.parse(e.categoryEntries.toString()),
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
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...list.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 20, top: 3),
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
          ),
        ),
      ],
    );
  }
}
