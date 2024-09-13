import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/attendance_repository_impl.dart';
import 'package:geotrackr/domain/repositories/implementation/employee_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/check_in.dart';
import 'package:geotrackr/domain/use_cases/check_out.dart';
import 'package:geotrackr/domain/use_cases/load_attendances.dart';
import 'package:geotrackr/domain/use_cases/load_employee.dart';
import 'package:geotrackr/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/check_in_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/check_out_bloc.dart';
import 'package:geotrackr/presentation/blocs/employee/load_employee_bloc.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_app_bar.dart';
import 'package:geotrackr/presentation/widgets/geotrackr_drawer.dart';
import 'package:geotrackr/presentation/widgets/home/home_page_body.dart';
import 'package:geotrackr/utils/custom_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // ignore: unused_local_variable
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    final attendanceRepository = AttendanceRepositoryImpl();
    final employeeRepository = EmployeeRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bloc = LoadEmployeeBloc(
              loadEmployee: LoadEmployee(employeeRepository),
            );
            bloc.load();
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) {
            final bloc = AttendanceBloc(
              loadAttendances: LoadAttendances(attendanceRepository),
            );
            bloc.load();
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) => CheckInBloc(
            checkIn: CheckIn(attendanceRepository),
          ),
        ),
        BlocProvider(
          create: (context) => CheckOutBloc(
            checkOut: CheckOut(attendanceRepository),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: const GeoTrackrAppBar(),
        drawer: const SafeArea(
          top: true,
          child: GeoTrackrDrawer(),
        ),
        body: const HomePageBody(),
      ),
    );
  }
}
