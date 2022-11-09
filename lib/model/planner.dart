class Planner {
  final int id;
  final DateTime date;
  final int procedureId;
  final String procedureName;
  final String categoryName;
  final String priceListName;

  Planner({
    required this.id,
    required this.date,
    required this.procedureId,
    required this.procedureName,
    required this.categoryName,
    required this.priceListName,
  });

  Map<String, dynamic> toMap() => {
        'ID': id,
        'DATE': date,
        'PROCEDURE_ID': procedureId,
        'PROCEDURE_NAME': procedureName,
        'CATEGORY_NAME': categoryName,
        'PRICE_LIST_NAME': priceListName,
      };

  factory Planner.fromString(Map<String, dynamic> value) => Planner(
        id: value['ID'],
        date: DateTime.parse(value['DATE']),
        procedureId: value['PROCEDURE_ID'],
        procedureName: value['PROCEDURE_NAME'],
        categoryName: value['CATEGORY_NAME'],
        priceListName: value['PRICE_LIST_NAME'],
      );
}
