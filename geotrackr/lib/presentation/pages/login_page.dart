import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/employee_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/login_employee.dart';
import 'package:geotrackr/presentation/blocs/login_bloc.dart';
import 'package:geotrackr/presentation/widgets/login/login_form.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(loginEmployee: LoginEmployee(EmployeeRepositoryImpl()))
            ..checkIfLoggedIn(),
      child: LoginForm(
          emailController: emailController,
          passwordController: passwordController),
    );
  }
}
