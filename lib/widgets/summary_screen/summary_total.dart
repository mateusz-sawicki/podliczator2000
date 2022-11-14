import 'package:flutter/material.dart';

class SummaryTotal extends StatelessWidget {
  final String summarySum;
  const SummaryTotal({required this.summarySum, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Saldo:"),
          ),
          Center(
            child: Text("$summarySum zł",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                )),
          )
        ],
      )),
    );
  }
}
