import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/procedures_screen/procedure_card.dart';
import 'package:provider/provider.dart';
import 'package:podliczator2000/widgets/planner_screen/planner_fetcher.dart';

class ProcedureFetcher extends StatefulWidget {
  const ProcedureFetcher({super.key});

  @override
  State<ProcedureFetcher> createState() => _ProcedureFetcherState();
}

class _ProcedureFetcherState extends State<ProcedureFetcher> {
  late Future _procedureList;

  Future _getProcedureList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.getProcedures();
  }

  @override
  void initState() {
    super.initState();
    _procedureList = _getProcedureList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _procedureList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Consumer<DatabaseProvider>(
              builder: (_, db, __) {
                var proceduresList = db.procedures;
                return proceduresList.isNotEmpty
                    ? ListView.separated(
                        itemCount: proceduresList.length,
                        itemBuilder: (_, i) {
                          return ProcedureCard(proceduresList[i]);
                        },
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1, color: Colors.grey),
                      )
                    : const Center(
                        child: Text('Brak procedur w bazie danych'),
                      );
              },
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
