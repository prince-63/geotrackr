import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/data/repositories/biometric_repository_impl.dart';
import 'package:geotrackr/data/repositories/location_repository_impl.dart';
import 'package:geotrackr/data/services/attendance_service.dart';
import 'package:geotrackr/domain/repositories/implementation/attendance_repository_impl.dart';
import 'package:geotrackr/domain/repositories/implementation/employee_repository_impl.dart';
import 'package:geotrackr/domain/repositories/implementation/office_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/load_employee.dart';
import 'package:geotrackr/domain/use_cases/office_check_in.dart';
import 'package:geotrackr/domain/use_cases/office_check_out.dart';
import 'package:geotrackr/domain/use_cases/remote_check_in.dart';
import 'package:geotrackr/domain/use_cases/remote_check_out.dart';
import 'package:geotrackr/presentation/blocs/attendance/office_check_in_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/office_check_out_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/remote_check_in_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/remote_check_out_bloc.dart';
import 'package:geotrackr/presentation/blocs/employee/load_employee_bloc.dart';
import 'package:geotrackr/presentation/widgets/home/home_page_body.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// The [HomePage] widget is a stateless widget that represents the home page of the application.
/// It uses the Bloc pattern to manage the state of various features such as employee loading, office check-in/out, and remote check-in/out.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the app is in dark mode to set the appropriate background color.
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    // Initialize repositories and services required for attendance and biometric operations.
    final attendanceRepository = AttendanceRepositoryImpl();
    final officeRepository = OfficeRepositoryImpl();
    final locationRepository = LocationRepositoryImpl();
    final biometricRepository = BiometricRepositoryImpl();
    final attendanceService = AttendanceService(
      attendanceRepository: attendanceRepository,
      locationRepository: locationRepository,
      biometricRepository: biometricRepository,
      officeRepository: officeRepository,
    );

    return MultiBlocProvider(
      providers: [
        // Provide the LoadEmployeeBloc to the widget tree.
        BlocProvider(
          create: (context) => LoadEmployeeBloc(
            loadEmployee: LoadEmployee(
              employeeRepository: EmployeeRepositoryImpl(),
            ),
          )..load(), // Load the employee data when the bloc is created.
        ),
      ],
      child: BlocBuilder<LoadEmployeeBloc, LoadEmployeeState>(
        builder: (context, state) {
          if (state is LoadEmployeeLoaded) {
            final employee = state.employee;

            return MultiBlocProvider(
              providers: [
                // Provide OfficeCheckInBloc and OfficeCheckOutBloc if the employee has the "OFFICE" role.
                if (employee.roles?.any((role) => role == "OFFICE") ??
                    false) ...[
                  BlocProvider(
                    create: (context) => OfficeCheckInBloc(
                      officeCheckIn: OfficeCheckIn(
                        attendanceService: attendanceService,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => OfficeCheckOutBloc(
                      officeCheckOut: OfficeCheckOut(
                        attendanceService: attendanceService,
                      ),
                    ),
                  ),
                ],
                // Provide RemoteCheckInBloc and RemoteCheckOutBloc if the employee has the "REMOTE" role.
                if (employee.roles?.any((role) => role == "REMOTE") ??
                    false) ...[
                  BlocProvider(
                    create: (context) => RemoteCheckInBloc(
                      remoteCheckIn: RemoteCheckIn(
                        attendanceService: attendanceService,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => RemoteCheckOutBloc(
                      remoteCheckOut: RemoteCheckOut(
                        attendanceService: attendanceService,
                      ),
                    ),
                  ),
                ],
              ],
              child: Scaffold(
                backgroundColor: backgroundColor,
                body: const HomePageBody(), // Display the home page body.
              ),
            );
          }

          // Show a loading indicator while the employee data is being loaded.
          return Scaffold(
            backgroundColor: backgroundColor,
            body: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
