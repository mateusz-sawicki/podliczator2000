class CategorySummary {
  final DateTime date;
  final String categoryName;
  final int categoryEntries;

  CategorySummary({
    required this.date,
    required this.categoryName,
    required this.categoryEntries,
  });

  Map<String, dynamic> toMap() => {
        'DATE': date,
        'CATEGORY_NAME': categoryName,
        'CATEGORY_ENTRIES': categoryEntries,
      };

  factory CategorySummary.fromString(Map<String, dynamic> value) =>
      CategorySummary(
        date: DateTime.parse(value['DATE']),
        categoryName: value['CATEGORY_NAME'],
        categoryEntries: value['CATEGORY_ENTRIES'],
      );
}
