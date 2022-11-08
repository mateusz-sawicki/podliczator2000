import 'package:flutter/material.dart';

import '../widgets/planner_screen/planner_fetcher.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dziennik'),
      ),
      body: const PlannerFetcher(),
    );
  }
}
