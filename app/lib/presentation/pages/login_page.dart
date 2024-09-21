import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/employee_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/login_employee.dart';
import 'package:geotrackr/presentation/blocs/login/login_bloc.dart';
import 'package:geotrackr/presentation/widgets/login/login_form.dart';

/// The [LoginPage] widget is a stateless widget that represents the login page of the application.
/// It uses the Bloc pattern to manage the state of the login process.
class LoginPage extends StatelessWidget {
  // Controllers for the email and password input fields.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// Constructor for [LoginPage].
  /// It initializes the class with the given key.
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // The BlocProvider is used to provide the LoginBloc to the widget tree.
      create: (context) => LoginBloc(
        // Create an instance of LoginBloc with the LoginEmployee use case.
        loginEmployee: LoginEmployee(EmployeeRepositoryImpl()),
      )..checkIfLoggedIn(), // Check if the user is already logged in when the bloc is created.
      // The LoginForm widget is the child of the BlocProvider.
      // It will have access to the LoginBloc provided by the BlocProvider.
      child: LoginForm(
        emailController: emailController,
        passwordController: passwordController,
      ),
    );
  }
}
