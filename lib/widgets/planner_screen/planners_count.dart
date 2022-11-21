import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlannersCount extends StatelessWidget {
  final int plannerQuantity;
  const PlannersCount({required this.plannerQuantity, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(left: 5),
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
            child: Center(
              child: Text(plannerQuantity.toString(),
                  style: GoogleFonts.merriweatherSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white)),
            )),
      ),
    );
  }
}
