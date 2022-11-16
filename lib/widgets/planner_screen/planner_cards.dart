import 'package:flutter/material.dart';
import 'package:podliczator2000/model/planner.dart';
import 'package:podliczator2000/widgets/focused_day_card.dart';
import 'package:podliczator2000/widgets/planner_screen/planners_count.dart';

class PlannerCards extends StatelessWidget {
  const PlannerCards({
    Key? key,
    required this.plannerList,
  }) : super(key: key);

  final List<Planner> plannerList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 70, child: FocusedDayCard()),
        Expanded(
            flex: 30,
            child: PlannersCount(plannerQuantity: plannerList.length)),
      ],
    );
  }
}
