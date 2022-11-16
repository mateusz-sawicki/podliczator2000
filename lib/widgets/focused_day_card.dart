import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:podliczator2000/constants/constant.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';

class FocusedDayCard extends StatelessWidget {
  const FocusedDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: true);
    final date =
        Constants().dateFormat.format(DateTime.parse(provider.focusedDay));

    return Padding(
        padding:
            const EdgeInsets.only(top: 15, left: 18, right: 18, bottom: 15),
        child: SizedBox(
          height: 50,
          child: Card(
            margin: EdgeInsets.zero,
            borderOnForeground: false,
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
                child: Text(date,
                    style: GoogleFonts.merriweatherSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.blue)),
              ),
            ),
          ),
        ));
  }
}