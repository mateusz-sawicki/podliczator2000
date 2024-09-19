import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:podliczator2000/model/summary.dart';

class SummaryDataTable extends StatefulWidget {
  final List<Summary> summaryList;
  const SummaryDataTable({required this.summaryList, super.key});

  @override
  State<SummaryDataTable> createState() => _SummaryDataTableState();
}

class _SummaryDataTableState extends State<SummaryDataTable> {
  int? sortColumnIndex;
  bool isAscending = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          minWidth: double.infinity, maxHeight: 500, minHeight: 200),
      child: SingleChildScrollView(
          child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: DataTable(
          sortColumnIndex: sortColumnIndex,
          columnSpacing: 20,
          sortAscending: isAscending,
          columns: [
            DataColumn(
                label: const Text(
                  "Procedury",
                  style: TextStyle(fontSize: 16),
                ),
                onSort: (columnIndex, _) {
                  setState(() {
                    sortColumnIndex = columnIndex;
                    if (isAscending) {
                      widget.summaryList.sort((summary1, summary2) =>
                          compareValues(isAscending, summary1.procedureName,
                              summary2.procedureName));
                      isAscending = false;
                    } else {
                      widget.summaryList.sort((summary1, summary2) =>
                          compareValues(isAscending, summary1.procedureName,
                              summary2.procedureName));
                      isAscending = true;
                    }
                  });
                }),
            DataColumn(
                label: const Text(
                  "Ilość",
                  style: TextStyle(fontSize: 16),
                ),
                onSort: (columnIndex, _) {
                  setState(() {
                    sortColumnIndex = columnIndex;
                    if (!isAscending) {
                      widget.summaryList.sort((summary1, summary2) =>
                          compareValues(!isAscending, summary1.procedureEntries,
                              summary2.procedureEntries));
                      isAscending = true;
                    } else {
                      widget.summaryList.sort((summary1, summary2) =>
                          compareValues(!isAscending, summary1.procedureEntries,
                              summary2.procedureEntries));
                      isAscending = false;
                    }
                  });
                }),
            DataColumn(
                label: const Text(
                  "Suma",
                  style: TextStyle(fontSize: 16),
                ),
                onSort: (columnIndex, _) {
                  setState(() {
                    sortColumnIndex = columnIndex;

                    if (!isAscending) {
                      widget.summaryList.sort((summary1, summary2) =>
                          compareValues(!isAscending, summary1.procedureSum,
                              summary2.procedureSum));
                      isAscending = true;
                    } else {
                      widget.summaryList.sort((summary1, summary2) =>
                          compareValues(!isAscending, summary1.procedureSum,
                              summary2.procedureSum));
                      isAscending = false;
                    }
                  });
                }),
          ],
          rows: widget.summaryList
              .map<DataRow>((element) => DataRow(cells: [
                    DataCell(
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element.procedureName,
                              style: const TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w700),
                              maxLines: 6,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(element.categoryName,
                                style: const TextStyle(fontSize: 12)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                "Cena: ${NumberFormat.currency(locale: 'pl_PL', symbol: 'zł').format(element.procedureAmount)}",
                                style: const TextStyle(
                                  fontSize: 12,
                                )),
                          ]),
                    ),
                    DataCell(Text(element.procedureEntries.toString())),
                    DataCell(Text(
                        NumberFormat.currency(locale: 'pl_PL', symbol: 'zł')
                            .format(element.procedureSum))),
                  ]))
              .toList(),
          dataRowMinHeight: MediaQuery.of(context).size.height / 6,
        ),
      )),
    );
  }

  int compareValues<T>(bool ascending, T value1, T value2) {
    if (ascending == true &&
        (value1.runtimeType == String && value2.runtimeType == String)) {
      return value1.toString().compareTo(value2.toString());
    } else if (ascending == false &&
        (value1.runtimeType == String && value2.runtimeType == String)) {
      return value2.toString().compareTo(value1.toString());
    } else if (ascending == true &&
        (value1.runtimeType == double && value2.runtimeType == double)) {
      return double.parse(value1.toString())
          .compareTo(double.parse(value2.toString()));
    } else if (ascending == false &&
        (value1.runtimeType == double && value2.runtimeType == double)) {
      return double.parse(value2.toString())
          .compareTo(double.parse(value1.toString()));
    } else if ((ascending == true &&
        (value1.runtimeType == int && value2.runtimeType == int))) {
      return int.parse(value1.toString())
          .compareTo(int.parse(value2.toString()));
    } else if ((ascending == false &&
        (value1.runtimeType == int && value2.runtimeType == int))) {
      return int.parse(value2.toString())
          .compareTo(int.parse(value1.toString()));
    } else {
      return value1.toString().compareTo(value2.toString());
    }
  }
}
