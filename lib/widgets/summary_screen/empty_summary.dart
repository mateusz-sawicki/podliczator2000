import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmptySummary extends StatelessWidget {
  const EmptySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
