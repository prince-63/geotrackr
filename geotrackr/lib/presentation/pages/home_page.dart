import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/attendance_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/check_in.dart';
import 'package:geotrackr/domain/use_cases/check_out.dart';
import 'package:geotrackr/presentation/blocs/attendance/check_in_bloc.dart';
import 'package:geotrackr/presentation/blocs/attendance/check_out_bloc.dart';
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

    return MultiBlocProvider(
      providers: [
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
        body: const HomePageBody(),
      ),
    );
  }
}
