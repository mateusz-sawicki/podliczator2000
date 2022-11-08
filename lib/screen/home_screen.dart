import 'package:flutter/material.dart';
import 'package:podliczator2000/screen/add_procedure_to_planner_screen.dart';
import 'package:podliczator2000/screen/diary_screen.dart';
import 'package:podliczator2000/screen/menu.dart';
import 'package:podliczator2000/screen/send_invoice_screen.dart';
import 'package:podliczator2000/screen/summary_screen.dart';
import 'package:podliczator2000/widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final pages = const [
    DiaryScreen(),
    SummaryScreen(),
    SendInvoiceScreen(),
    MenuScreen()
  ];

  @override
  Widget build(BuildContext context) {
    void onChangeTab(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar:
          BottomNavBar(index: _selectedIndex, onChangeTab: onChangeTab),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProcedureToPlannerScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
