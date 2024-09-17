import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/attendance_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/load_attendances.dart';
import 'package:geotrackr/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:geotrackr/presentation/widgets/attendance/attendance_body.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = AttendanceBloc(
          loadAttendances: LoadAttendances(
            AttendanceRepositoryImpl(),
          ),
        );
        bloc.load();
        return bloc;
      },
      child: const AttendanceBody(),
    );
  }
}
