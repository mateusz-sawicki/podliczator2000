class CategorySummary {
  final String categoryName;
  final int categoryEntries;

  CategorySummary({
    required this.categoryName,
    required this.categoryEntries,
  });

  Map<String, dynamic> toMap() => {
        'CATEGORY_NAME': categoryName,
        'CATEGORY_ENTRIES': categoryEntries,
      };

  factory CategorySummary.fromString(Map<String, dynamic> value) =>
      CategorySummary(
        categoryName: value['CATEGORY_NAME'],
        categoryEntries: value['CATEGORY_ENTRIES'],
      );
}
