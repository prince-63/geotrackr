part of 'employee_update_bloc.dart';

@immutable
abstract class EmployeeUpdateState {}

class EmployeeUpdateInitial extends EmployeeUpdateState {}

class EmployeeUpdateLoading extends EmployeeUpdateState {}

class EmployeeUpdateLoaded extends EmployeeUpdateState {
  final Employee employee;

  EmployeeUpdateLoaded(this.employee);
}

class EmployeeUpdateError extends EmployeeUpdateState {
  final String message;

  EmployeeUpdateError(this.message);
}
