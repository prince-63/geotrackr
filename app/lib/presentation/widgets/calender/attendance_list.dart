import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/attendance/attendance_details_row.dart';
import 'package:geotrackr/domain/entities/attendance.dart';

/// The [AttendanceList] widget is a stateless widget that displays a list of attendance records for a selected day.
/// It uses a function to get the attendance records for the selected day.
class AttendanceList extends StatelessWidget {
  final DateTime
      selectedDay; // The selected day for which to display attendance records.
  final List<Attendance> Function(DateTime)
      getAttendanceForDay; // Function to get attendance records for the selected day.

  /// Constructor for [AttendanceList].
  /// It initializes the class with the given selected day and function to get attendance records.
  const AttendanceList({
    super.key,
    required this.selectedDay,
    required this.getAttendanceForDay,
  });

  @override
  Widget build(BuildContext context) {
    final attendances = getAttendanceForDay(selectedDay);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.grey[800] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        itemCount: attendances.length,
        itemBuilder: (context, index) {
          final attendance = attendances[index];
          return Container(
            margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${attendance.date!.day}/${attendance.date!.month}/${attendance.date!.year}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  AttendanceDetailRow(
                    label: 'Check-In Time:',
                    value:
                        '${attendance.checkInTime!.hour}:${attendance.checkInTime!.minute}:${attendance.checkInTime!.second}',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 8.0),
                  AttendanceDetailRow(
                    label: 'Check-In Location:',
                    value:
                        '${attendance.checkInLocationLatitude}, ${attendance.checkInLocationLongitude}',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 8.0),
                  AttendanceDetailRow(
                    label: 'Check-Out Time:',
                    value:
                        '${attendance.checkOutTime!.hour}:${attendance.checkOutTime!.minute}:${attendance.checkOutTime!.second}',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 8.0),
                  AttendanceDetailRow(
                    label: 'Check-Out Location:',
                    value:
                        '${attendance.checkOutLocationLatitude}, ${attendance.checkOutLocationLongitude}',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 8.0),
                  AttendanceDetailRow(
                    label: 'Status:',
                    value: '${attendance.status}',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 8.0),
                  AttendanceDetailRow(
                    label: 'Total Hours:',
                    value: '${attendance.totalHours}',
                    textColor: textColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
