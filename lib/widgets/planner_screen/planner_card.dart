import 'package:flutter/material.dart';
import 'package:podliczator2000/model/planner.dart';

class PlannerCard extends StatelessWidget {
  final Planner planner;
  const PlannerCard(this.planner, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
          child: ListTile(
        dense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        tileColor: Colors.grey[200],
        title: Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 5),
          child: Text(
            planner.procedureName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(children: [
                const Icon(
                  Icons.grid_view_rounded,
                  size: 16,
                ),
                Text(
                  planner.categoryName,
                  style: const TextStyle(fontSize: 14),
                )
              ]),
            ),
            Row(children: [
              const Icon(
                Icons.request_quote,
                size: 16,
              ),
              Text(
                planner.priceListName,
                style: const TextStyle(fontSize: 14),
              )
            ]),
          ]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                // showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //           title: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.info_outline,
                //                 size: 60,
                //                 color: Colors.blue,
                //               ),
                //               Text(
                //                 'Czy na pewno chcesz usunąć procedurę?',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           actions: [
                //             TextButton(
                //                 onPressed: () async {
                //                   Navigator.pop(context);
                //                 },
                //                 child: Text('Tak')),
                //             TextButton(
                //                 onPressed: () {
                //                   Navigator.pop(context);
                //                 },
                //                 child: Text('Anuluj'))
                //           ],
                //         ));
              },
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
