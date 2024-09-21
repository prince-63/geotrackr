import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/use_cases/login_employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Bloc class for managing login states and events.
class LoginBloc extends Cubit<LoginState> {
  final LoginEmployee loginEmployee;

  /// Constructor for [LoginBloc].
  /// It initializes the class with the given [LoginEmployee] use case.
  LoginBloc({required this.loginEmployee}) : super(LoginInitial());

  /// Logs in the employee using the provided email and password.
  /// Emits different states based on the result of the login operation.
  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      final Employee employee = await loginEmployee(email, password);
      emit(LoginLoaded(employee));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  /// Checks if the employee is already logged in.
  /// Emits different states based on the result of the check.
  Future<void> checkIfLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        final Employee employee = await loginEmployee.loadEmployee();
        emit(LoginLoaded(employee));
      } else {
        emit(LoginInitial());
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}

/// Abstract class representing the different states of login.
abstract class LoginState {}

/// Initial state of login.
class LoginInitial extends LoginState {}

/// State when login is in progress.
class LoginLoading extends LoginState {}

/// State when login is successful.
class LoginLoaded extends LoginState {
  final Employee employee;

  /// Constructor for [LoginLoaded].
  /// It initializes the class with the loaded [Employee] object.
  LoginLoaded(this.employee);
}

/// State when there is an error during login.
class LoginError extends LoginState {
  final String message;

  /// Constructor for [LoginError].
  /// It initializes the class with the given error message.
  LoginError(this.message);
}
