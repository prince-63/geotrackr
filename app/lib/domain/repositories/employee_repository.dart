import 'package:geotrackr/domain/entities/employee.dart';

abstract class EmployeeRepository {
  Future<Employee> login(String email, String password);
  Future<Employee> loadEmployee();
  Future<Employee> updateEmployee(String employeeName, String employeeEmail, String employeeContactNumber);
}
