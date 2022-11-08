import 'package:flutter/material.dart';
import 'package:podliczator2000/model/procedure.dart';

class ProcedureCard extends StatelessWidget {
  final Procedure procedure;
  const ProcedureCard(this.procedure, {super.key});

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(children: [
              const Icon(Icons.grid_view_rounded),
              Text(procedure.categoryName, style: const TextStyle(fontSize: 14))
            ]),
          ),
          Row(children: [
            const Icon(Icons.request_quote),
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
          onPressed: () {},
          icon: const Icon(Icons.keyboard_double_arrow_right_rounded),
          iconSize: 40,
        ),
      ]),
    );
  }
}
