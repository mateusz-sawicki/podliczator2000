class PriceList {
  final int id;
  final String name;
  final DateTime? validFrom;
  final DateTime? validTo;
  final int businessId;
  final int isActive;

  PriceList({
    required this.id,
    required this.name,
    required this.validFrom,
    this.validTo,
    required this.businessId,
    required this.isActive,
  });

  Map<String, dynamic> toMap() => {
        'ID': id,
        'NAME': name,
        'VALID_FROM': validFrom,
        'VALID_TO': validTo,
        'BUSINESS_ID': businessId,
        'IS_ACTIVE': isActive
      };

  factory PriceList.fromString(Map<String, dynamic> value) => PriceList(
      id: value['ID'],
      name: value['NAME'],
      validFrom: DateTime.tryParse(value['VALID_FROM']),
      validTo: DateTime.tryParse(value['VALID_TO'] ?? ""),
      businessId: value['BUSINESS_ID'],
      isActive: value['IS_ACTIVE']);
}
