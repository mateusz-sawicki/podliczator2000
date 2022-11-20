import 'package:flutter/material.dart';
import 'package:podliczator2000/constants/constant.dart';
import 'package:provider/provider.dart';

import '../../provider/database_provider.dart';

class SummaryDate extends StatefulWidget {
  const SummaryDate({super.key});

  @override
  State<SummaryDate> createState() => _SummaryDateState();
}

class _SummaryDateState extends State<SummaryDate> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: true);
    DateTime pickedDate = DateTime.parse(provider.pickedDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              pickedDate = DateTime(
                  pickedDate.year, pickedDate.month, pickedDate.day - 1);
              provider.pickedDate =
                  Constants().sqlDateFormat.format(pickedDate);
              provider.getSummary(Constants().sqlDateFormat.format(pickedDate));
              provider.getCategoriesSummary(
                  Constants().sqlDateFormat.format(pickedDate));
            },
            icon: const Icon(Icons.arrow_back)),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: Text(Constants().dateFormat.format(pickedDate)),
          onTap: () {},
        ),
        IconButton(
            onPressed: () {
              pickedDate = DateTime(
                  pickedDate.year, pickedDate.month, pickedDate.day + 1);
              provider.pickedDate =
                  Constants().sqlDateFormat.format(pickedDate);
              provider.getSummary(Constants().sqlDateFormat.format(pickedDate));
              provider.getCategoriesSummary(
                  Constants().sqlDateFormat.format(pickedDate));
            },
            icon: const Icon(Icons.arrow_forward)),
      ],
    );
  }
}
