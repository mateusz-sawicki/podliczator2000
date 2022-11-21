import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';

import 'summary_pie_chart.dart';

class SummaryChartCard extends StatefulWidget {
  const SummaryChartCard({super.key});

  @override
  State<SummaryChartCard> createState() => _SummaryChartCardState();
}

class _SummaryChartCardState extends State<SummaryChartCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Consumer<DatabaseProvider>(
        builder: (_, db, __) {
          var list = db.categorySummaries;
          var total = db.calculateTotalCategories();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Text("Procedury: "),
              ),
              Center(
                  child: Text(total.toStringAsFixed(0),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ))),
              SummaryPieChart(total: total, list: list),
            ],
          );
        },
      ),
    );
  }
}
