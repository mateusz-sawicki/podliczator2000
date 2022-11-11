import 'package:flutter/material.dart';
import 'package:podliczator2000/provider/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../constants/constant.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final _firstDay = DateTime.utc(1970, 01, 01);
  final _lastDay = DateTime(DateTime.now().year + 10);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl-PL', null);
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      child: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: _firstDay,
        lastDay: _lastDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        rangeSelectionMode: RangeSelectionMode.disabled,
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              provider.focusedDay = Constants().formatter.format(focusedDay);
            });
            provider.getPlanners(Constants().formatter.format(_focusedDay));
          } else {
            showDatePicker(
                    context: context,
                    initialDate: _selectedDay,
                    firstDate: _firstDay,
                    lastDate: _lastDay,
                    locale: const Locale('pl', ''))
                .then(
              (date) => setState(
                () {
                  if (date == null) {
                    return;
                  }
                  _selectedDay = date;
                  _focusedDay = _selectedDay;
                  provider
                      .getPlanners(Constants().formatter.format(_focusedDay));
                },
              ),
            );
          }
        },
        headerVisible: false,
        calendarFormat: CalendarFormat.week,
        daysOfWeekHeight: 15,
        rowHeight: 50,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          cellAlignment: Alignment.center,
          cellMargin: const EdgeInsets.all(5),
          rowDecoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
          ),
          outsideTextStyle: const TextStyle(color: Colors.white),
          defaultTextStyle: const TextStyle(color: Colors.white),
          weekendTextStyle: const TextStyle(color: Colors.red),
          todayDecoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle),
          selectedTextStyle:
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          selectedDecoration: BoxDecoration(
            color: Colors.lightBlue[100],
            shape: BoxShape.circle,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          decoration: const BoxDecoration(color: Colors.transparent),
          weekdayStyle: const TextStyle(color: Colors.white),
          weekendStyle: const TextStyle(color: Colors.red),
          dowTextFormatter: (date, locale) =>
              DateFormat.E('pl-PL').format(date)[0].toUpperCase(),
        ),
      ),
    );
  }
}
