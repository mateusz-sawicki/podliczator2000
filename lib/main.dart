import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:podliczator2000/screen/diary_screen.dart';
import 'package:provider/provider.dart';
import 'model/category.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => DatabaseProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiaryScreen(),
    );
  }
}
