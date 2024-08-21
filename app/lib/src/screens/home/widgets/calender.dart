import 'package:flutter/material.dart';
import 'package:idcard/src/services/attendance/attendance_service.dart';
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
  late Map<DateTime, List> _attendanceData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAttendanceData();
  }

  List _getAttendanceForDay(DateTime day) {
    return _attendanceData[day] ?? [];
  }

  void _loadAttendanceData() async {
    final data = await AttendanceService.getAllAttendance(context);

    setState(() {
      _attendanceData = data;
      _attendanceData.addAll({
        DateTime.utc(2024, 8, 1): ['PRESENT'],
        DateTime.utc(2024, 8, 2): ['ABSENT'],
      });
      print(_attendanceData);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2024, 8, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
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
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      List attendance = _getAttendanceForDay(day);
                      Color? backgroundColor;
                      if (attendance.contains('PRESENT')) {
                        backgroundColor = Colors.green;
                      } else if (attendance.contains('ABSENT')) {
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
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0)),
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
                // total attendance
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Present Attendance: '),
                      Text('${_totalPresentAttendance} days'),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  int get _totalPresentAttendance {
    int count = 0;
    _attendanceData.forEach((key, value) {
      if (value.contains('PRESENT')) {
        count++;
      }
    });
    return count;
  }
}
