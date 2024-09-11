import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

class UpdateEmployeeDetails {
  final EmployeeRepository _employeeRepository;

  UpdateEmployeeDetails(this._employeeRepository);

  Future<Employee> call(String employeeName, String employeeEmail,
      String employeeContactNumber) async {
    return await _employeeRepository.updateEmployee(
        employeeName, employeeEmail, employeeContactNumber);
  }
}
