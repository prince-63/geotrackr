import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:geotrackr/domain/entities/attendance.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;
  final List<Attendance> Function(DateTime) getAttendanceForDay;
  final Color textColor;

  const CalendarWidget({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    required this.getAttendanceForDay,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2024, 9, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      calendarFormat: calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: onDaySelected,
      onFormatChanged: onFormatChanged,
      onPageChanged: onPageChanged,
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          List<Attendance> attendance = getAttendanceForDay(day);
          Color? cellBackgroundColor;
          if (attendance.any((a) => a.status == 'CHECKED_OUT')) {
            cellBackgroundColor = Colors.green;
          } else if (attendance.any((a) => a.status == 'CHECKED_IN')) {
            cellBackgroundColor = Colors.red;
          } else if (attendance.isEmpty) {
            if (day.isBefore(DateTime.now())) {
              cellBackgroundColor = Colors.grey;
            }
          }
          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cellBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(color: textColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
