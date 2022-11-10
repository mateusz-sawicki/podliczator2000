import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/widgets/planner_screen/planners_count.dart';
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
            ? Column(
                children: [
                  PlannersCount(plannerQuantity: plannerList.length),
                  Expanded(
                    child: ListView.builder(
                      itemCount: plannerList.length,
                      itemBuilder: (_, i) {
                        if (i == plannerList.length - 1) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 15, left: 15, right: 15),
                            child: PlannerCard(plannerList[i]),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: PlannerCard(plannerList[i]),
                        );
                      },
                    ),
                  )
                ],
              )
            : const Center(
                child: Text('Brak procedur w danym dniu'),
              );
      },
    );
  }
}
