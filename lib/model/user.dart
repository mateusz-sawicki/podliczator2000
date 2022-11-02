class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => {'ID': id, 'NAME': name};

  factory User.fromString(Map<String, dynamic> value) =>
      User(id: value['ID'], name: value['NAME']);
}
