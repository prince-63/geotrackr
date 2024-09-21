import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/employee_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/employee_update_details.dart';
import 'package:geotrackr/presentation/blocs/employee/employee_update_bloc.dart';
import 'package:geotrackr/presentation/widgets/default_app_bar.dart';
import 'package:geotrackr/presentation/widgets/employee_update/employee_update_form.dart';

/// The [EmployeeUpdatePage] widget is a stateless widget that represents the page for updating employee details.
/// It uses the Bloc pattern to manage the state of the employee update process.
class EmployeeUpdatePage extends StatelessWidget {
  const EmployeeUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // The BlocProvider is used to provide the EmployeeUpdateBloc to the widget tree.
      create: (context) => EmployeeUpdateBloc(
        // Create an instance of EmployeeUpdateBloc with the EmployeeUpdateDetails use case.
        employeeUpdateDetails: EmployeeUpdateDetails(EmployeeRepositoryImpl()),
      ),
      // The Scaffold widget provides the structure for the page.
      child: Scaffold(
        // The DefaultAppBar widget is used as the app bar for the page.
        appBar: DefaultAppBar(
          title: "Update Employee Details",
          // The onBackButtonPressed callback is used to navigate back to the previous page.
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
        ),
        // The EmployeeUpdateForm widget is used as the body of the page.
        // It will have access to the EmployeeUpdateBloc provided by the BlocProvider.
        body: EmployeeUpdateForm(),
      ),
    );
  }
}
