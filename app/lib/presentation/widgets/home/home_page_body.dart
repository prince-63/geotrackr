import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/load_today_attendance_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/office_check_in_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/office_check_out_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/remote_check_in_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/remote_check_out_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/presentation/widgets/check_box.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// The [HomePageBody] widget is a stateful widget that represents the body of the home page.
/// It manages the state of check-in and check-out processes using Bloc.
class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool isCheckedIn = false;
  bool isCheckedOut = false;

  @override
  void initState() {
    super.initState();

    final officeCheckInBloc = context.read<OfficeCheckInBloc?>();
    final remoteCheckInBloc = context.read<RemoteCheckInBloc?>();
    final loadTodayAttendanceBloc = context.read<LoadTodayAttendanceBloc?>();

    loadTodayAttendanceBloc?.stream.listen((state) {
      if (state is LoadTodayAttendanceLoaded) {
        setState(() {
          isCheckedIn = state.attendance.status == 'CHECKED_IN' ||
              state.attendance.status == 'CHECKED_OUT';
          isCheckedOut = state.attendance.status == 'CHECKED_OUT';
        });
      }
    });

    loadTodayAttendanceBloc?.load();

    if (officeCheckInBloc != null) {
      officeCheckInBloc.stream.listen((state) {
        if (state is OfficeCheckInSuccess) {
          setState(() {
            isCheckedIn = true;
          });
        }
      });
    }

    if (remoteCheckInBloc != null) {
      remoteCheckInBloc.stream.listen((state) {
        if (state is RemoteCheckInSuccess) {
          setState(() {
            isCheckedIn = true;
          });
        }
      });
    }

    final officeCheckOutBloc = context.read<OfficeCheckOutBloc?>();
    final remoteCheckOutBloc = context.read<RemoteCheckOutBloc?>();

    if (officeCheckOutBloc != null) {
      officeCheckOutBloc.stream.listen((state) {
        if (state is OfficeCheckOutSuccess) {
          setState(() {
            isCheckedOut = true;
          });
        }
      });
    }

    if (remoteCheckOutBloc != null) {
      remoteCheckOutBloc.stream.listen((state) {
        if (state is RemoteCheckOutSuccess) {
          setState(() {
            isCheckedOut = true;
          });
        }
      });
    }
  }

  void _checkIn() {
    final officeCheckInBloc = context.read<OfficeCheckInBloc?>();
    final remoteCheckInBloc = context.read<RemoteCheckInBloc?>();

    officeCheckInBloc?.checkIn();
    remoteCheckInBloc?.checkIn();
  }

  void _checkOut() {
    final officeCheckOutBloc = context.read<OfficeCheckOutBloc?>();
    final remoteCheckOutBloc = context.read<RemoteCheckOutBloc?>();

    officeCheckOutBloc?.checkOut();
    remoteCheckOutBloc?.checkOut();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    final today = DateTime.now();
    final dateString = '${today.day}/${today.month}/${today.year}';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (context.read<OfficeCheckInBloc?>() != null) ...[
              BlocListener<OfficeCheckInBloc, OfficeCheckInState>(
                listener: (context, state) {
                  if (state is OfficeCheckInSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomMessages.showBeautifulMessage(
                          context, state.message);
                    });
                  } else if (state is OfficeCheckInError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomMessages.showErrorMessage(context, state.message);
                    });
                  }
                },
                child: CheckBox(
                  context: context,
                  title: 'Office Check-In',
                  isChecked: isCheckedIn,
                  onPressed: _checkIn,
                  date: dateString,
                  status: isCheckedIn ? 'Checked In' : 'Not Checked In',
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                ),
              ),
              const SizedBox(height: 16.0),
              BlocListener<OfficeCheckOutBloc, OfficeCheckOutState>(
                listener: (context, state) {
                  if (state is OfficeCheckOutSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomMessages.showBeautifulMessage(
                          context, state.message);
                    });
                  } else if (state is OfficeCheckOutError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomMessages.showErrorMessage(context, state.message);
                    });
                  }
                },
                child: CheckBox(
                  context: context,
                  title: 'Office Check-Out',
                  isChecked: isCheckedOut,
                  onPressed: _checkOut,
                  date: dateString,
                  status: isCheckedOut ? 'Checked Out' : 'Not Checked Out',
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                ),
              ),
              const SizedBox(height: 16.0),
            ],
            if (context.read<RemoteCheckInBloc?>() != null) ...[
              BlocListener<RemoteCheckInBloc, RemoteCheckInState>(
                listener: (context, state) {
                  if (state is RemoteCheckInSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomMessages.showBeautifulMessage(
                          context, state.message);
                    });
                  } else if (state is RemoteCheckInError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomMessages.showErrorMessage(context, state.message);
                    });
                  }
                },
                child: CheckBox(
                  context: context,
                  title: 'Remote Check-In',
                  isChecked: isCheckedIn,
                  onPressed: _checkIn,
                  date: dateString,
                  status: isCheckedIn ? 'Checked In' : 'Not Checked In',
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                ),
              ),
              const SizedBox(height: 16.0),
              BlocListener<RemoteCheckOutBloc, RemoteCheckOutState>(
                listener: (context, state) {
                  if (state is RemoteCheckOutSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomMessages.showBeautifulMessage(
                          context, state.message);
                    });
                  } else if (state is RemoteCheckOutError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      CustomMessages.showErrorMessage(context, state.message);
                    });
                  }
                },
                child: CheckBox(
                  context: context,
                  title: 'Remote Check-Out',
                  isChecked: isCheckedOut,
                  onPressed: _checkOut,
                  date: dateString,
                  status: isCheckedOut ? 'Checked Out' : 'Not Checked Out',
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
