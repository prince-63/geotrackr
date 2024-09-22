import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/auth_repository_impl.dart';
import 'package:geotrackr/domain/repositories/implementation/employee_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/check_login_status.dart';
import 'package:geotrackr/domain/use_cases/login_employee.dart';
import 'package:geotrackr/presentation/blocs/login/login_bloc.dart';
import 'package:geotrackr/presentation/blocs/login/login_status_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/presentation/widgets/login/login_page_body.dart';

/// The [LoginPage] widget is a stateless widget that represents the login page of the application.
/// It uses the Bloc pattern to manage the state of the login process.
class LoginPage extends StatelessWidget {
  /// Constructor for [LoginPage].
  /// It initializes the class with the given key.
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            loginEmployee: LoginEmployee(
              AuthRepositoryImpl(),
            ),
          ),
        ),
        BlocProvider<LoginStatusBloc>(
          create: (context) => LoginStatusBloc(
            checkLoginStatus: CheckLoginStatus(
              EmployeeRepositoryImpl(),
            ),
          )..add(
              CheckLoginStatusEvent()), // Trigger the event to check login status
        ),
      ],
      child: BlocListener<LoginStatusBloc, LoginStatusState>(
        listener: (context, state) {
          if (state is LoginStatusLoaded) {
            // Navigate to the home page if the user is already logged in
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/home');
            });
          } else if (state is LoginStatusError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomMessages.showErrorMessage(context, state.message);
            });
          }
        },
        child: LoginPageBody(),
      ),
    );
  }
}
