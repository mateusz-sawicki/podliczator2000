import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
        child: Card(
      child: DataTable(
        sortColumnIndex: sortColumnIndex,
        sortAscending: isAscending,
        columns: [
          DataColumn(
              label: const Text("Procedury"),
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
              label: const Text("Ilość"),
              onSort: (columnIndex, _) {
                setState(() {
                  sortColumnIndex = columnIndex;
                  if (!isAscending) {
                    widget.summaryList.sort((summary1, summary2) =>
                        compareValues(
                            !isAscending,
                            summary1.procedureEntries.toString(),
                            summary2.procedureEntries.toString()));
                    isAscending = true;
                  } else {
                    widget.summaryList.sort((summary1, summary2) =>
                        compareValues(
                            !isAscending,
                            summary1.procedureEntries.toString(),
                            summary2.procedureEntries.toString()));
                    isAscending = false;
                  }
                });
              }),
          DataColumn(
              label: const Text("Suma"),
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
                                fontSize: 13, overflow: TextOverflow.ellipsis),
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
                  ),
                  DataCell(Text(element.procedureEntries.toString())),
                  DataCell(Text("${element.procedureSum}zł")),
                ]))
            .toList(),
        dataRowHeight: MediaQuery.of(context).size.height / 8,
      ),
    ));
  }

  int compareValues<T>(bool ascending, T value1, T value2) {
    if (ascending == true &&
        (value1.runtimeType == String && value1.runtimeType == String)) {
      return value1.toString().compareTo(value2.toString());
    } else if (ascending == false &&
        (value1.runtimeType == String && value1.runtimeType == String)) {
      return value2.toString().compareTo(value1.toString());
    } else if (ascending == true &&
        (value1.runtimeType == double && value1.runtimeType == double)) {
      return double.parse(value1.toString())
          .compareTo(double.parse(value2.toString()));
    } else {
      return double.parse(value2.toString())
          .compareTo(double.parse(value1.toString()));
    }
  }
}
