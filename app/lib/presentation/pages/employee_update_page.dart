import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/employee_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/employee_update_details.dart';
import 'package:geotrackr/presentation/blocs/employee/employee_update_bloc.dart';
import 'package:geotrackr/presentation/widgets/default_app_bar.dart';
import 'package:geotrackr/presentation/widgets/employee_update/employee_update_form.dart';

class EmployeeUpdatePage extends StatelessWidget {
  const EmployeeUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeUpdateBloc(
        employeeUpdateDetails: EmployeeUpdateDetails(EmployeeRepositoryImpl()),
      ),
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "Update Employee Details",
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
        ),
        body: EmployeeUpdateForm(),
      ),
    );
  }
}
