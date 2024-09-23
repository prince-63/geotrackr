import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/employee_repository_impl.dart';
import 'package:geotrackr/domain/repositories/implementation/office_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/load_employee.dart';
import 'package:geotrackr/domain/use_cases/load_office.dart';
import 'package:geotrackr/presentation/blocs/employee/load_employee_bloc.dart';
import 'package:geotrackr/presentation/blocs/office/load_office_bloc.dart';
import 'package:geotrackr/presentation/widgets/default_app_bar.dart';
import 'package:geotrackr/presentation/widgets/profile/profile_body.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// The [ProfilePage] widget is a stateless widget that represents the profile page of the application.
/// It uses the Bloc pattern to manage the state of loading employee and office data.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the app is in dark mode to set the appropriate background color.
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? CustomColor.darkBackgroundColor
        : CustomColor.lightBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: DefaultAppBar(
        title: 'Profile',
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: MultiBlocProvider(
        providers: [
          // Provide the LoadEmployeeBloc to the widget tree.
          BlocProvider(
            create: (context) {
              final bloc = LoadEmployeeBloc(
                loadEmployee: LoadEmployee(
                  employeeRepository: EmployeeRepositoryImpl(),
                ),
              );
              bloc.load(); // Load the employee data when the bloc is created.
              return bloc;
            },
          ),
          // Provide the LoadOfficeBloc to the widget tree.
          BlocProvider(
            create: (context) {
              final bloc = LoadOfficeBloc(
                loadOffice: LoadOffice(
                  OfficeRepositoryImpl(),
                ),
              );
              bloc.load(); // Load the office data when the bloc is created.
              return bloc;
            },
          ),
        ],
        child: SafeArea(
          child: BlocBuilder<LoadEmployeeBloc, LoadEmployeeState>(
            builder: (context, employeeState) {
              if (employeeState is LoadEmployeeLoaded) {
                final employee = employeeState.employee;
                return BlocBuilder<LoadOfficeBloc, LoadOfficeState>(
                  builder: (context, officeState) {
                    if (officeState is LoadOfficeLoaded) {
                      final office = officeState.office;
                      // Display the profile body with the loaded employee and office data.
                      return ProfileBody(employee: employee, office: office);
                    } else if (officeState is LoadOfficeLoading) {
                      // Show a loading indicator while the office data is being loaded.
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                );
              } else if (employeeState is LoadEmployeeLoading) {
                // Show a loading indicator while the employee data is being loaded.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
