import 'package:flutter/material.dart';
import 'package:podliczator2000/model/planner.dart';
import 'package:podliczator2000/widgets/planner_screen/confirm_box.dart';

class PlannerCard extends StatelessWidget {
  final Planner planner;
  const PlannerCard(this.planner, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 15, 12, 20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 5),
                    child: Text(
                      planner.procedureName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.grid_view_rounded,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              planner.categoryName,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.request_quote,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            planner.priceListName,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => ConfirmBox(
                              plannerId: planner.id,
                            ));
                  },
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
