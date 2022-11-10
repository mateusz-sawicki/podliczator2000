import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';

import '../../model/planner.dart';

class ConfirmBox extends StatelessWidget {
  final Planner planner;
  const ConfirmBox({required this.planner, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.info_outline,
            size: 60,
            color: Colors.blue,
          ),
          Text(
            'Czy na pewno chcesz usunąć procedurę?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
              provider.deletePlanner(planner.id);
            },
            child: const Text('Tak')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Anuluj'))
      ],
    );
  }
}
