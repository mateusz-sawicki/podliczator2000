class Category {
  final int id;
  final String name;
  final int priceListId;

  Category({
    required this.id,
    required this.name,
    required this.priceListId,
  });

  Map<String, dynamic> toMap() =>
      {'ID': id, 'NAME': name, 'PRICE_LIST_ID': priceListId};

  factory Category.fromString(Map<String, dynamic> value) => Category(
      id: value['ID'],
      name: value['NAME'],
      priceListId: value['PRICE_LIST_ID']);
}
