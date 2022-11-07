import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/procedures_screen/procedure_card.dart';

class ProcedureList extends StatelessWidget {
  const ProcedureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var proceduresList = db.procedures;
        return proceduresList.isNotEmpty
            ? ListView.separated(
                itemCount: proceduresList.length,
                itemBuilder: (_, i) {
                  return ProcedureCard(proceduresList[i]);
                },
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: Colors.grey),
              )
            : const Center(
                child: Text('Brak procedur w bazie danych'),
              );
      },
    );
  }
}
