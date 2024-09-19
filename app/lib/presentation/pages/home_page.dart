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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

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
        BlocProvider(
          create: (context) => LoadEmployeeBloc(
            loadEmployee: LoadEmployee(
              employeeRepository: EmployeeRepositoryImpl(),
            ),
          )..load(),
        ),
      ],
      child: BlocBuilder<LoadEmployeeBloc, LoadEmployeeState>(
        builder: (context, state) {
          if (state is LoadEmployeeLoaded) {
            final employee = state.employee;

            return MultiBlocProvider(
              providers: [
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
                body: const HomePageBody(),
              ),
            );
          }

          // Show a loading indicator while the employee is being loaded
          return Scaffold(
            backgroundColor: backgroundColor,
            body: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
