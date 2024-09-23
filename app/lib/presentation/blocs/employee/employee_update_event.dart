part of 'employee_update_bloc.dart';

/// Abstract class representing the different events for employee update.
@immutable
abstract class EmployeeUpdateEvent {}

/// Event to update the employee details.
class EmployeeUpdate extends EmployeeUpdateEvent {
  final String employeeName; // The name of the employee.
  final String employeeEmail; // The email address of the employee.
  final String employeeContactNumber; // The contact number of the employee.

  /// Constructor for [EmployeeUpdate].
  /// It initializes the class with the given employee details.
  EmployeeUpdate({
    required this.employeeName,
    required this.employeeEmail,
    required this.employeeContactNumber,
  });
}