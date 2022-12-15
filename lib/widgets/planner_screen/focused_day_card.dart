import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return SizedBox(
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(right: 5),
        borderOnForeground: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
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
    );
  }
}
