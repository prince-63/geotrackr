import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:geotrackr/presentation/widgets/attendance/attendance_details_row.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';

/// The [AttendanceBody] widget is a stateless widget that represents the body of the attendance page.
/// It uses the Bloc pattern to manage the state of loading attendance data.
class AttendanceBody extends StatelessWidget {
  const AttendanceBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.grey[800] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        if (state is AttendanceLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AttendanceLoaded) {
          if (state.attendances.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomMessages.showErrorMessage(context, "No Attendance found");
            });
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: state.attendances.length,
              itemBuilder: (context, index) {
                final attendance = state.attendances[index];
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
    );
  }
}
