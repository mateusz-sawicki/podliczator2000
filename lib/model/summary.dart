class Summary {
  final DateTime date;
  final int procedureId;
  final String procedureName;
  final String categoryName;
  final String priceListName;
  final double procedureAmount;
  final int procedureEntries;
  final double procedureSum;

  Summary({
    required this.date,
    required this.procedureId,
    required this.procedureName,
    required this.categoryName,
    required this.priceListName,
    required this.procedureAmount,
    required this.procedureEntries,
    required this.procedureSum,
  });

  Map<String, dynamic> toMap() => {
        'DATE': date,
        'PROCEDURE_ID': procedureId,
        'PROCEDURE_NAME': procedureName,
        'CATEGORY_NAME': categoryName,
        'PRICE_LIST_NAME': priceListName,
        'PROCEDURE_AMOUNT': procedureAmount,
        'PROCEDURE_ENTRIES': procedureEntries,
        'PROCEDURE_SUM': procedureSum,
      };

  factory Summary.fromString(Map<String, dynamic> value) => Summary(
        date: DateTime.parse(value['DATE']),
        procedureId: value['PROCEDURE_ID'],
        procedureName: value['PROCEDURE_NAME'],
        categoryName: value['CATEGORY_NAME'],
        priceListName: value['PRICE_LIST_NAME'],
        procedureAmount:
            double.parse((value['PROCEDURE_AMOUNT']).toStringAsFixed(2)),
        procedureEntries: value['PROCEDURE_ENTRIES'],
        procedureSum: double.parse(value['PROCEDURE_SUM'].toStringAsFixed(2)),
      );
}
