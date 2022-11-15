import 'package:flutter/material.dart';
import 'package:podliczator2000/model/summary_period.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_details.dart';
import 'package:provider/provider.dart';

class SummaryFetcher extends StatefulWidget {
  final SummaryPeriod period;
  const SummaryFetcher({required this.period, super.key});

  @override
  State<SummaryFetcher> createState() => _SummaryFetcherState();
}

class _SummaryFetcherState extends State<SummaryFetcher> {
  late Future _summaryList;

  Future _setSummaryPeriod() async {
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<DatabaseProvider>(context, listen: false);
      provider.period = widget.period;
    });
  }

  Future _getSummaryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.getSummary(provider.focusedDay);
  }

  @override
  void initState() {
    super.initState();
    _summaryList = _getSummaryList();
    _setSummaryPeriod();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _summaryList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const SummaryDetails();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
