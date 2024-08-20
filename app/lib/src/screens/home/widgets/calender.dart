import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List> _attendanceData = {
    DateTime.utc(2024, 8, 1): ['Present'],
    DateTime.utc(2024, 8, 9): ['Absent'],
    DateTime.utc(2024, 8, 10): ['Present'],
    DateTime.utc(2024, 8, 15): ['Present'],
    DateTime.utc(2024, 8, 16): ['Absent'],
    DateTime.utc(2024, 8, 17): ['Present'],
    DateTime.utc(2024, 8, 23): ['Present'],
    DateTime.utc(2024, 8, 24): ['Absent'],
    DateTime.utc(2024, 8, 30): ['Present'],
    DateTime.utc(2024, 8, 31): ['Present'],
    DateTime.utc(2024, 9, 1): ['Present'],
    // Add more dates and attendance status here
  };

  List _getAttendanceForDay(DateTime day) {
    return _attendanceData[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          // eventLoader: _getAttendanceForDay,
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              List attendance = _getAttendanceForDay(day);
              Color? backgroundColor;
              if (attendance.contains('Present')) {
                backgroundColor = Colors.green;
              } else if (attendance.contains('Absent')) {
                backgroundColor = Colors.red;
              }
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day.day.toString(),
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            itemCount: _getAttendanceForDay(_selectedDay).length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_getAttendanceForDay(_selectedDay)[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
