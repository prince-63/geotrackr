part of 'employee_update_bloc.dart';

/// Abstract class representing the different states of employee update.
@immutable
abstract class EmployeeUpdateState {}

/// Initial state of employee update.
class EmployeeUpdateInitial extends EmployeeUpdateState {}

/// State when employee update is in progress.
class EmployeeUpdateLoading extends EmployeeUpdateState {}

/// State when employee update is successful.
class EmployeeUpdateLoaded extends EmployeeUpdateState {
  final Employee employee;

  /// Constructor for [EmployeeUpdateLoaded].
  /// It initializes the class with the updated [Employee] object.
  EmployeeUpdateLoaded(this.employee);
}

/// State when there is an error during employee update.
class EmployeeUpdateError extends EmployeeUpdateState {
  final String message;

  /// Constructor for [EmployeeUpdateError].
  /// It initializes the class with the given error message.
  EmployeeUpdateError(this.message);
}