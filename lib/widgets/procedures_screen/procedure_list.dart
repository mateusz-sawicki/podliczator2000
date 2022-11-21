import 'package:flutter/material.dart';
import 'package:podliczator2000/widgets/procedures_screen/procedure_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:podliczator2000/provider/database_provider.dart';

class ProcedureList extends StatelessWidget {
  const ProcedureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var proceduresList = db.procedures;
        return proceduresList.isNotEmpty
            ? Expanded(
                child: ListView.separated(
                  itemCount: proceduresList.length,
                  itemBuilder: (_, i) {
                    return ProcedureListTile(proceduresList[i]);
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: Colors.grey),
                ),
              )
            : const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Brak procedur odpowiadających wpisanej frazie',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
      },
    );
  }
}
