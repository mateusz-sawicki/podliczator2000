import 'package:flutter/material.dart';
import 'package:podliczator2000/model/add_planner.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';

class CounterBox extends StatelessWidget {
  final int procedureId;
  final String procedureName;
  const CounterBox(
      {required this.procedureId, required this.procedureName, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: true);
    return AlertDialog(
      title: Column(
        children: [
          RichText(
              text: TextSpan(
                  text: "Podaj ilość dla procedury: ",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: <TextSpan>[
                TextSpan(
                    text: procedureName,
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
                const TextSpan(
                  text: " do wprowadzenia",
                )
              ])),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  provider.procedureQuantity--;
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.blue,
                  size: 40,
                ),
                alignment: Alignment.center,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text(
                  "${provider.procedureQuantity}",
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  provider.procedureQuantity++;
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                  size: 40,
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Anuluj',
              style: TextStyle(color: Colors.blue),
            )),
        TextButton(
            onPressed: () async {
              final planner = AddPlanner(
                date: provider.focusedDay,
                procedureId: procedureId,
              );
              provider.addPlanner(planner, provider.procedureQuantity);
              FocusManager.instance.primaryFocus?.unfocus();
              Future.delayed(const Duration(milliseconds: 0), () {
                final snackbar = SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        Icons.done,
                        color: Colors.green[800],
                      ),
                      const SizedBox(width: 10),
                      const Text('Pomyślnie dodano procedurę'),
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  duration: const Duration(milliseconds: 1000),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              });
              Future.delayed(const Duration(milliseconds: 1200), () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              });
              provider.getPlanners(planner.date);
            },
            child: const Text(
              'Dodaj',
              style: TextStyle(color: Colors.blue),
            )),
      ],
    );
  }
}
