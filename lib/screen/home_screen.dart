import 'package:flutter/material.dart';
import 'package:podliczator2000/screen/add_procedure_to_planner_screen.dart';
import 'package:podliczator2000/screen/diary_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const DiaryScreen(),
      floatingActionButton: FloatingActionButton(
        mini: false,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProcedureToPlannerScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
