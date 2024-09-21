import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/widgets/calender/attendance_list.dart';
import 'package:geotrackr/presentation/widgets/calender_widget.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/utils/custom_color.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:geotrackr/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:geotrackr/domain/entities/attendance.dart';

/// The [Calender] widget is a stateful widget that represents the calendar page of the application.
/// It uses the Bloc pattern to manage the state of loading attendance data.
class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late Map<DateTime, List<Attendance>> _attendanceData = {};

  @override
  void initState() {
    super.initState();
  }

  List<Attendance> _getAttendanceForDay(DateTime day) {
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
            _attendanceData = _mapAttendancesToCalendar(state.attendances);
            return Column(
              children: [
                CalendarWidget(
                  selectedDay: _selectedDay,
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
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
                  getAttendanceForDay: _getAttendanceForDay,
                  textColor: textColor,
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: AttendanceList(
                    selectedDay: _selectedDay,
                    getAttendanceForDay: _getAttendanceForDay,
                  ),
                ),
              ],
            );
          } else if (state is AttendanceError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomMessages.showErrorMessage(context, state.message);
            });
            return Container();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomMessages.showErrorMessage(context, 'No data found');
            });
            return Container();
          }
        },
      ),
    );
  }

  Map<DateTime, List<Attendance>> _mapAttendancesToCalendar(
      List<Attendance> attendances) {
    final Map<DateTime, List<Attendance>> attendanceMap = {};
    for (var attendance in attendances) {
      final date = DateTime(
          attendance.date!.year, attendance.date!.month, attendance.date!.day);
      if (attendanceMap[date] == null) {
        attendanceMap[date] = [];
      }
      attendanceMap[date]!.add(attendance);
    }
    return attendanceMap;
  }
}
