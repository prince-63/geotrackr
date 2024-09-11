import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

class EmployeeUpdateDetails {
  final EmployeeRepository employeeRepository;

  EmployeeUpdateDetails(this.employeeRepository);

  Future<Employee> call(String employeeName, String employeeEmail,
      String employeeContactNumber) async {
    return await employeeRepository.updateEmployee(
        employeeName, employeeEmail, employeeContactNumber);
  }
}
