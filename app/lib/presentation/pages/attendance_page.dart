import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/attendance_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/load_attendances.dart';
import 'package:geotrackr/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:geotrackr/presentation/widgets/attendance/attendance_body.dart';

/// The [AttendancePage] widget is a stateless widget that represents the attendance page of the application.
/// It uses the Bloc pattern to manage the state of the attendance data.
class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // The BlocProvider is used to provide the AttendanceBloc to the widget tree.
      create: (context) {
        // Create an instance of AttendanceBloc with the LoadAttendances use case.
        final bloc = AttendanceBloc(
          loadAttendances: LoadAttendances(
            AttendanceRepositoryImpl(),
          ),
        );
        // Load the attendance data when the bloc is created.
        bloc.load();
        return bloc;
      },
      // The AttendanceBody widget is the child of the BlocProvider.
      // It will have access to the AttendanceBloc provided by the BlocProvider.
      child: const AttendanceBody(),
    );
  }
}
