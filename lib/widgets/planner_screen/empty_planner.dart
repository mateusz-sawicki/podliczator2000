import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmptyPlanner extends StatelessWidget {
  const EmptyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(bottom: 70),
            constraints: const BoxConstraints.expand(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(MdiIcons.playlistRemove,
                    size: 250, color: Colors.grey[500]),
                Text('Brak procedur',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.grey[500])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('naciśnij ',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 20, color: Colors.grey[500])),
                    // ignore: prefer_const_constructors
                    Icon(
                      Icons.add_circle,
                      color: Colors.blue,
                    ),
                    Text(' aby dodać procedurę',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 20, color: Colors.grey[500])),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
