import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/attendance_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/load_attendances.dart';
import 'package:geotrackr/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:geotrackr/presentation/widgets/working_hours/working_hours_body.dart';

/// The [WorkingHoursPage] widget is a stateless widget that represents the working hours page of the application.
/// It uses the Bloc pattern to manage the state of loading attendance data.
class WorkingHoursPage extends StatelessWidget {
  const WorkingHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // The BlocProvider is used to provide the AttendanceBloc to the widget tree.
      create: (context) {
        final bloc = AttendanceBloc(
          // Create an instance of AttendanceBloc with the LoadAttendances use case.
          loadAttendances: LoadAttendances(AttendanceRepositoryImpl()),
        );
        bloc.load(); // Load the attendance data when the bloc is created.
        return bloc;
      },
      // The WorkingHoursBody widget is the child of the BlocProvider.
      // It will have access to the AttendanceBloc provided by the BlocProvider.
      child: const WorkingHoursBody(),
    );
  }
}
