import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/planner_screen/empty_planner.dart';
import 'package:podliczator2000/widgets/planner_screen/planner_cards.dart';
import 'package:provider/provider.dart';

import 'planner_card.dart';

class PlannerList extends StatelessWidget {
  const PlannerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var plannerList = db.planners;
        return plannerList.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: PlannerCards(plannerList: plannerList),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 10),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, i) => PlannerCard(plannerList[i]),
                          childCount: plannerList.length),
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  PlannerCards(plannerList: plannerList),
                  const Expanded(child: EmptyPlanner()),
                ],
              );
      },
    );
  }
}
