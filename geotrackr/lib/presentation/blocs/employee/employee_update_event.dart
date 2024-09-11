part of 'employee_update_bloc.dart';

@immutable
abstract class EmployeeUpdateEvent {
}

class EmployeeUpdate extends EmployeeUpdateEvent {
  final String employeeName;
  final String employeeEmail;
  final String employeeContactNumber;

  EmployeeUpdate(
      this.employeeName, this.employeeEmail, this.employeeContactNumber);
}
