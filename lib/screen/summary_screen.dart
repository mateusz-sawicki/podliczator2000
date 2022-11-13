import 'package:flutter/material.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_details.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Podsumowanie'),
            bottom: const TabBar(labelPadding: EdgeInsets.zero, tabs: [
              Tab(
                text: 'Dzienne',
              ),
              Tab(
                text: 'Tygodniowe',
              ),
              Tab(
                text: 'Miesięczne',
              ),
              Tab(
                text: 'Dowolne',
              )
            ]),
          ),
          body: SummaryDetails(),
        ));
  }
}
