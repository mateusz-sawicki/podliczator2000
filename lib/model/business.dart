class Business {
  final int id;
  final String name;
  final int userId;

  Business({
    required this.id,
    required this.name,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {'ID': id, 'NAME': name, 'USER_ID': userId};

  factory Business.fromString(Map<String, dynamic> value) =>
      Business(id: value['ID'], name: value['NAME'], userId: value['USER_ID']);
}
