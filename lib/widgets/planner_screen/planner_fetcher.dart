import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';

class PlannerFetcher extends StatefulWidget {
  const PlannerFetcher({super.key});

  @override
  State<PlannerFetcher> createState() => _PlannerFetcherState();
}

class _PlannerFetcherState extends State<PlannerFetcher> {
  late Future _plannerList;

  Future _getPlannerList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.getPlanners();
  }

  @override
  void initState() {
    super.initState();
    _plannerList = _getPlannerList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _plannerList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Consumer<DatabaseProvider>(
              builder: (_, db, __) {
                var list = db.planners;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, i) =>
                      ListTile(title: Text(list[i].date.toString())),
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
