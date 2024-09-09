import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/use_cases/login_employee.dart';

class LoginBloc extends Cubit<LoginState> {
  final LoginEmployee loginEmployee;

  LoginBloc({required this.loginEmployee}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      final Employee employee = await loginEmployee(email, password);
      emit(LoginLoaded(employee));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final Employee employee;

  LoginLoaded(this.employee);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
