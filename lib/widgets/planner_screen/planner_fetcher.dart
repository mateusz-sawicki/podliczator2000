import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/planner_screen/calendar_widget.dart';
import 'package:podliczator2000/widgets/planner_screen/planner_list.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';

class PlannerFetcher extends StatefulWidget {
  const PlannerFetcher({super.key});

  @override
  State<PlannerFetcher> createState() => _PlannerFetcherState();
}

class _PlannerFetcherState extends State<PlannerFetcher> {
  late Future _plannerList;

  Future _getPlannerList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    DateTime date = DateTime.now();
    return await provider.getPlanners(Constants().formatter.format(date));
  }

  @override
  void initState() {
    super.initState();
    _plannerList = _getPlannerList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CalendarWidget(),
        Expanded(
          child: FutureBuilder(
            future: _plannerList,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const PlannerList();
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
      ],
    );
  }
}
