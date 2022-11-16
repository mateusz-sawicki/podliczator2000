import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmptyPlanner extends StatelessWidget {
  const EmptyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 70),
      constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(MdiIcons.playlistRemove, size: 250, color: Colors.grey[300]),
          Text('Brak procedur',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.grey[300])),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('naciśnij ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey[300])),
              Icon(
                Icons.add_circle,
                color: Colors.grey[300],
              ),
              Text(' aby dodać procedurę',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey[300])),
            ],
          )
        ],
      ),
    );
  }
}
