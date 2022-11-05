class Procedure {
  final int id;
  final String name;
  final double amount;
  final int categoryId;

  Procedure({
    required this.id,
    required this.name,
    required this.amount,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() => {
        'NAME': name,
        'AMOUNT': amount.toString(),
        'CATEGORY_ID': categoryId,
      };

  factory Procedure.fromString(Map<String, dynamic> value) => Procedure(
      id: value['ID'],
      name: value['NAME'],
      amount: double.parse(value['AMOUNT'].toString()),
      categoryId: value['CATEGORY_ID']);
}
