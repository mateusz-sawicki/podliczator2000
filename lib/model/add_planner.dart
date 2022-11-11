class AddPlanner {
  final String date;
  final int procedureId;

  AddPlanner({
    required this.date,
    required this.procedureId,
  });

  Map<String, dynamic> toMap() => {
        'DATE': date,
        'PROCEDURE_ID': procedureId,
      };

  factory AddPlanner.fromString(Map<String, dynamic> value) => AddPlanner(
        date: value['DATE'],
        procedureId: value['PROCEDURE_ID'],
      );
}
