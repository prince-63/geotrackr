import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/utils/custom_color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:geotrackr/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:geotrackr/domain/entities/attendance.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late Map<DateTime, List<String>> _attendanceData = {};

  @override
  void initState() {
    super.initState();
  }

  List<String> _getAttendanceForDay(DateTime day) {
    return _attendanceData[_normalizeDate(day)] ?? [];
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AttendanceLoaded) {
            print("Attendances: ${state.attendances}");
            _attendanceData = _mapAttendancesToCalendar(state.attendances);
            print("Attendance data: $_attendanceData");
            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2024, 9, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
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
                      print("Day: $day");
                      List<String> attendance = _getAttendanceForDay(day);
                      print("Attendance $attendance");
                      Color? cellBackgroundColor;
                      if (attendance.contains('CHECKED_OUT')) {
                        cellBackgroundColor = Colors.green;
                      } else if (attendance.contains('CHECKED_IN')) {
                        cellBackgroundColor = Colors.red;
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
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _getAttendanceForDay(_selectedDay).length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _getAttendanceForDay(_selectedDay)[index],
                          style: TextStyle(color: textColor),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Present Attendance: ',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${_totalPresentAttendance} days',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else if (state is AttendanceError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomMessages.showErrorMessage(context, state.message);
            });
            print("Error: ${state.message}");
            return Container();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomMessages.showErrorMessage(context, "An error occurred");
            });
            return Container();
          }
        },
      ),
    );
  }

  Map<DateTime, List<String>> _mapAttendancesToCalendar(
      List<Attendance> attendances) {
    final Map<DateTime, List<String>> attendanceMap = {};
    for (var attendance in attendances) {
      final date = DateTime(
          attendance.date!.year, attendance.date!.month, attendance.date!.day);
      if (attendanceMap[date] == null) {
        attendanceMap[date] = [];
      }
      attendanceMap[date]!.add(attendance.status!);
    }

    print("Attendance map: $attendanceMap");
    return attendanceMap;
  }

  int get _totalPresentAttendance {
    int count = 0;
    _attendanceData.forEach((key, value) {
      if (value.contains('CHECKED_OUT')) {
        count++;
      }
    });
    return count;
  }
}
