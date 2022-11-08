class PriceList {
  final int id;
  final String name;
  final DateTime validFrom;
  final DateTime validTo;
  final int businessId;

  PriceList({
    required this.id,
    required this.name,
    required this.validFrom,
    required this.validTo,
    required this.businessId,
  });

  Map<String, dynamic> toMap() => {
        'ID': id,
        'NAME': name,
        'VALID_FROM': validFrom,
        'VALID_TO': validTo,
        'BUSINESS_ID': businessId
      };

  factory PriceList.fromString(Map<String, dynamic> value) => PriceList(
      id: value['ID'],
      name: value['NAME'],
      validFrom: DateTime.parse(value['VALID_FROM']),
      validTo: DateTime.parse(value['VALID_TO']),
      businessId: value['BUSINESS_ID']);
}
