import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:podliczator2000/constants/constant.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/planner_screen/planner_fetcher.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          centerTitle: true,
          toolbarHeight: 56,
          title: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child:
                Text('podliczajka', style: GoogleFonts.pacifico(fontSize: 25)),
            onTap: () {
              final provider =
                  Provider.of<DatabaseProvider>(context, listen: false);
              provider.focusedDay =
                  Constants().sqlDateFormat.format(DateTime.now());
              provider.getPlanners(provider.focusedDay);
            },
          )),
      body: const PlannerFetcher(),
    );
  }
}
