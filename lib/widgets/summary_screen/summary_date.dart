import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:podliczator2000/constants/constant.dart';
import 'package:podliczator2000/model/summary_period.dart';
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
            color: Colors.blue,
            onPressed: () {
              if (provider.period == SummaryPeriod.daily) {
                pickedDate = DateTime(
                    pickedDate.year, pickedDate.month, pickedDate.day - 1);
                provider.pickedDate =
                    Constants().sqlDateFormat.format(pickedDate);
                provider
                    .getSummary(Constants().sqlDateFormat.format(pickedDate));
                provider.getCategoriesSummary(
                    Constants().sqlDateFormat.format(pickedDate));
              }
              if (provider.period == SummaryPeriod.weekly) {
                pickedDate = DateTime(
                    pickedDate.year, pickedDate.month, pickedDate.day - 7);
                provider.pickedDate =
                    Constants().sqlDateFormat.format(pickedDate);
                provider
                    .getSummary(Constants().sqlDateFormat.format(pickedDate));
                provider.getCategoriesSummary(
                    Constants().sqlDateFormat.format(pickedDate));
              }
              if (provider.period == SummaryPeriod.monthly) {
                pickedDate = DateTime(
                    pickedDate.year, pickedDate.month - 1, pickedDate.day);
                pickedDate =
                    DateTime.parse(provider.getStartOfMonth(pickedDate));
                provider.pickedDate =
                    Constants().sqlDateFormat.format(pickedDate);
                provider
                    .getSummary(Constants().sqlDateFormat.format(pickedDate));
                provider.getCategoriesSummary(
                    Constants().sqlDateFormat.format(pickedDate));
              }
              if (provider.period == SummaryPeriod.yearly) {
                pickedDate = DateTime(pickedDate.year - 1);
                pickedDate =
                    DateTime.parse(provider.getStartOfMonth(pickedDate));
                provider.pickedDate =
                    Constants().sqlDateFormat.format(pickedDate);
                provider
                    .getSummary(Constants().sqlDateFormat.format(pickedDate));
                provider.getCategoriesSummary(
                    Constants().sqlDateFormat.format(pickedDate));
              }
            },
            icon: const Icon(Icons.arrow_back)),
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: SizedBox(
                height: 40,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.only(right: 5),
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
                            child: pickedDateWidget(
                                pickedDate, provider.period))))),
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(provider.pickedDate),
                      firstDate: DateTime.utc(1970, 01, 01),
                      lastDate: DateTime(DateTime.now().year + 10))
                  .then((date) => setState(() {
                        if (date == null) {
                          return;
                        }
                        provider.pickedDate =
                            Constants().sqlDateFormat.format(date);
                        provider
                            .getSummary(Constants().sqlDateFormat.format(date));
                        provider.getCategoriesSummary(
                            Constants().sqlDateFormat.format(date));
                      }));
            },
          ),
        ),
        IconButton(
            color: Colors.blue,
            onPressed: () {
              if (provider.period == SummaryPeriod.daily) {
                pickedDate = DateTime(
                    pickedDate.year, pickedDate.month, pickedDate.day + 1);
                provider.pickedDate =
                    Constants().sqlDateFormat.format(pickedDate);
                provider
                    .getSummary(Constants().sqlDateFormat.format(pickedDate));
                provider.getCategoriesSummary(
                    Constants().sqlDateFormat.format(pickedDate));
              }
              if (provider.period == SummaryPeriod.weekly) {
                pickedDate = DateTime(
                    pickedDate.year, pickedDate.month, pickedDate.day + 7);
                provider.pickedDate =
                    Constants().sqlDateFormat.format(pickedDate);
                provider
                    .getSummary(Constants().sqlDateFormat.format(pickedDate));
                provider.getCategoriesSummary(
                    Constants().sqlDateFormat.format(pickedDate));
              }
              if (provider.period == SummaryPeriod.monthly) {
                pickedDate = DateTime(
                    pickedDate.year, pickedDate.month + 1, pickedDate.day);
                pickedDate =
                    DateTime.parse(provider.getStartOfMonth(pickedDate));
                provider.pickedDate =
                    Constants().sqlDateFormat.format(pickedDate);
                provider
                    .getSummary(Constants().sqlDateFormat.format(pickedDate));
                provider.getCategoriesSummary(
                    Constants().sqlDateFormat.format(pickedDate));
              }
              if (provider.period == SummaryPeriod.yearly) {
                pickedDate = DateTime(pickedDate.year + 1);
                pickedDate =
                    DateTime.parse(provider.getStartOfMonth(pickedDate));
                provider.pickedDate =
                    Constants().sqlDateFormat.format(pickedDate);
                provider
                    .getSummary(Constants().sqlDateFormat.format(pickedDate));
                provider.getCategoriesSummary(
                    Constants().sqlDateFormat.format(pickedDate));
              }
            },
            icon: const Icon(Icons.arrow_forward)),
      ],
    );
  }
}

Widget pickedDateWidget(DateTime date, SummaryPeriod period) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      getPickedDateString(period, date),
      style: GoogleFonts.merriweatherSans(
          fontWeight: FontWeight.w700, fontSize: 18, color: Colors.blue),
    ),
  );
}

String getPickedDateString(SummaryPeriod period, DateTime date) {
  if (period == SummaryPeriod.weekly) {
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    DateTime endOfWeek =
        date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    return "${DateFormat.yMMMd('pl_PL').format(DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day))} - ${DateFormat.yMMMd('pl_PL').format(DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day))}";
  }
  if (period == SummaryPeriod.monthly) {
    return toBeginningOfSentenceCase(
        DateFormat.yMMMM('pl_PL').format(DateTime(date.year, date.month)))!;
  }
  if (period == SummaryPeriod.yearly) {
    return DateFormat.y('pl_PL').format(DateTime(date.year));
  }
  return Constants().dateFormat.format(date);
}
