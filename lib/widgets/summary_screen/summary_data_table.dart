import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';

class SummaryDataTable extends StatefulWidget {
  const SummaryDataTable({super.key});

  @override
  State<SummaryDataTable> createState() => _SummaryDataTableState();
}

class _SummaryDataTableState extends State<SummaryDataTable> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var summaryList = db.summaries;
      return summaryList.isNotEmpty
          ? SingleChildScrollView(
              child: DataTable(
              columns: const [
                DataColumn(label: Text("Procedury")),
                DataColumn(label: Text("Ilość")),
                DataColumn(label: Text("Suma")),
              ],
              rows: summaryList
                  .map<DataRow>((element) => DataRow(cells: [
                        DataCell(Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  element.procedureName,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 5,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Cena: ${element.procedureAmount}zł",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ))
                              ]),
                        )),
                        DataCell(Text(element.procedureEntries.toString())),
                        DataCell(Text("${element.procedureSum}zł")),
                      ]))
                  .toList(),
              dataRowHeight:
                  50 + MediaQuery.of(context).size.height / summaryList.length,
            ))
          : const Center(
              child: Text("chuj"),
            );
    });
  }
}
