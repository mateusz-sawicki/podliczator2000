class Procedure {
  final int id;
  final String name;
  final double amount;
  final int categoryId;
  final String categoryName;
  final String priceListName;

  Procedure({
    required this.id,
    required this.name,
    required this.amount,
    required this.categoryId,
    required this.categoryName,
    required this.priceListName,
  });

  Map<String, dynamic> toMap() => {
        'NAME': name,
        'AMOUNT': amount.toString(),
        'CATEGORY_ID': categoryId,
        'CATEGORY_NAME': categoryName,
        'PRICE_LIST_NAME': priceListName
      };

  factory Procedure.fromString(Map<String, dynamic> value) => Procedure(
      id: value['ID'],
      name: value['NAME'],
      amount: double.parse(value['AMOUNT'].toString()),
      categoryId: value['CATEGORY_ID'],
      categoryName: value['CATEGORY_NAME'],
      priceListName: value['PRICE_LIST_NAME']);
}
