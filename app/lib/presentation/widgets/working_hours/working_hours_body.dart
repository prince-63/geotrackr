import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/presentation/widgets/default_app_bar.dart';

class WorkingHoursBody extends StatelessWidget {
  const WorkingHoursBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? const Color.fromARGB(255, 51, 56, 61)
        : const Color.fromARGB(255, 195, 222, 241);
    final textColor = !isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      appBar: DefaultAppBar(
        title: "Working Hours",
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${attendance.date!.day}/${attendance.date!.month}/${attendance.date!.year}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '${attendance.totalHours}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
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
      ),
    );
  }
}
