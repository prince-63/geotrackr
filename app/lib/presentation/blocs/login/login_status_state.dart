part of 'login_status_bloc.dart';

abstract class LoginStatusState {}

class LoginStatusInitial extends LoginStatusState {}

class LoginStatusLoading extends LoginStatusState {}

class LoginStatusLoaded extends LoginStatusState {
  final Employee employee;

  LoginStatusLoaded(this.employee);
}

class LoginStatusError extends LoginStatusState {
  final String message;

  LoginStatusError(this.message);
}
