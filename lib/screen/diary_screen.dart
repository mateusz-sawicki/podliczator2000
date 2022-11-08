import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/planner_screen/planner_fetcher.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () {},
          )),
      body: const PlannerFetcher(),
    );
  }
}
