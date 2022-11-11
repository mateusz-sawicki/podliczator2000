import 'package:flutter/material.dart';
import 'package:podliczator2000/model/add_planner.dart';
import 'package:podliczator2000/model/procedure.dart';
import 'package:provider/provider.dart';

import '../../provider/database_provider.dart';

class ProcedureListTile extends StatelessWidget {
  final Procedure procedure;
  const ProcedureListTile(this.procedure, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          procedure.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(children: [
              const Icon(
                Icons.grid_view_rounded,
                size: 18,
              ),
              Text(procedure.categoryName, style: const TextStyle(fontSize: 14))
            ]),
          ),
          Row(children: [
            const Icon(
              Icons.request_quote,
              size: 18,
            ),
            Text(procedure.priceListName, style: const TextStyle(fontSize: 14))
          ]),
        ]),
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.keyboard_arrow_right_rounded),
          iconSize: 40,
        ),
        IconButton(
          onPressed: () {
            final planner = AddPlanner(
              date: provider.focusedDay,
              procedureId: procedure.id,
            );

            provider.addPlanner(planner);

            Navigator.pop(context, true);
            provider.getPlanners(planner.date);
          },
          icon: const Icon(Icons.keyboard_double_arrow_right_rounded),
          iconSize: 40,
        ),
      ]),
    );
  }
}
