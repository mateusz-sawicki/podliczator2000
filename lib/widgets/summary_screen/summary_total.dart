import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummaryTotal extends StatelessWidget {
  final double summarySum;
  const SummaryTotal({required this.summarySum, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Saldo:"),
              ),
              Center(
                child: Text(
                    NumberFormat.currency(locale: 'pl_PL', symbol: 'zł')
                        .format(summarySum),
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
