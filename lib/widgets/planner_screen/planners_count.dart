import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:podliczator2000/screen/summary_screen.dart';

class PlannersCount extends StatelessWidget {
  final int plannerQuantity;
  const PlannersCount({required this.plannerQuantity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 18, right: 18, bottom: 5),
        child: SizedBox(
          height: 50,
          child: Card(
            margin: EdgeInsets.zero,
            borderOnForeground: false,
            color: Colors.blue,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SummaryScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(plannerQuantity.toString(),
                        style: GoogleFonts.merriweatherSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.white)),
                  )),
            ),
          ),
        ));
  }
}
