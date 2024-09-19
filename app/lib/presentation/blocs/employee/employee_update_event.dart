part of 'employee_update_bloc.dart';

@immutable
abstract class EmployeeUpdateEvent {}

class EmployeeUpdate extends EmployeeUpdateEvent {
  final String employeeName;
  final String employeeEmail;
  final String employeeContactNumber;

  EmployeeUpdate({
    required this.employeeName,
    required this.employeeEmail,
    required this.employeeContactNumber,
  });
}
