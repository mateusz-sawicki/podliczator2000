class Planner {
  final int id;
  final DateTime date;
  final int procedureId;

  Planner({
    required this.id,
    required this.date,
    required this.procedureId,
  });

  Map<String, dynamic> toMap() =>
      {'ID': id, 'DATE': date, 'PROCEDURE_ID': procedureId};

  factory Planner.fromString(Map<String, dynamic> value) => Planner(
      id: value['ID'],
      date: DateTime.parse(value['DATE']),
      procedureId: value['PROCEDURE_ID']);
}
