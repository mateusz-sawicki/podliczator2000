import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';

class ConfirmBox extends StatelessWidget {
  final int plannerId;
  const ConfirmBox({required this.plannerId, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
              provider.deletePlanner(plannerId);
              final snackbar = SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green[800],
                    ),
                    const SizedBox(width: 10),
                    const Text('Pomyślnie usunięto procedurę'),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                duration: const Duration(milliseconds: 1000),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
