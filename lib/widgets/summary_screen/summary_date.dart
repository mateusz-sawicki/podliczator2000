import 'package:flutter/material.dart';

class SummaryDate extends StatefulWidget {
  const SummaryDate({super.key});

  @override
  State<SummaryDate> createState() => _SummaryDateState();
}

class _SummaryDateState extends State<SummaryDate> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        Text("Data"),
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
      ],
    );
  }
}
