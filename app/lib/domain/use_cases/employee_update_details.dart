import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

/// This class handles the updating of employee details.
class EmployeeUpdateDetails {
  final EmployeeRepository employeeRepository;

  /// Constructor for [EmployeeUpdateDetails].
  /// It initializes the class with the given [EmployeeRepository].
  EmployeeUpdateDetails(this.employeeRepository);

  /// Updates the employee details.
  /// Takes the employee name, email, and contact number as parameters.
  /// Returns an [Employee] object if the update is successful.
  Future<Employee> call(String employeeName, String employeeEmail,
      String employeeContactNumber) async {
    return await employeeRepository.updateEmployee(
        employeeName, employeeEmail, employeeContactNumber);
  }
}
