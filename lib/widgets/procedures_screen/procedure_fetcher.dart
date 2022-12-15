import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/procedures_screen/procedure_list.dart';
import 'package:podliczator2000/widgets/procedures_screen/search_procedure.dart';
import 'package:provider/provider.dart';

class ProcedureFetcher extends StatefulWidget {
  const ProcedureFetcher({super.key});

  @override
  State<ProcedureFetcher> createState() => _ProcedureFetcherState();
}

class _ProcedureFetcherState extends State<ProcedureFetcher> {
  late Future _procedureList;

  Future _getProcedureList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.getProcedures(2);
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
            return Column(
              children: const [
                ProcedureSearch(),
                ProcedureList(),
              ],
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
