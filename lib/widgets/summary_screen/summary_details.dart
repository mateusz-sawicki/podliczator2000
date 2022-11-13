import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/summary_screen/summary_data_table.dart';
import 'package:provider/provider.dart';

class SummaryDetails extends StatefulWidget {
  const SummaryDetails({super.key});

  @override
  State<SummaryDetails> createState() => _SummaryDetailsState();
}

class _SummaryDetailsState extends State<SummaryDetails> {
  late Future _summaryList;

  Future _getSummaryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.getSummary(provider.focusedDay);
  }

  @override
  void initState() {
    super.initState();
    _summaryList = _getSummaryList();
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
            return const SummaryDataTable();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
