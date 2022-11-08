import 'package:flutter/material.dart';
import 'package:podliczator2000/widgets/procedures_screen/procedure_fetcher.dart';

class AddProcedureToPlannerScreen extends StatelessWidget {
  const AddProcedureToPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista procedur'),
      ),
      body: const ProcedureFetcher(),
    );
  }
}
