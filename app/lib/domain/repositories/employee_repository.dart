import 'package:geotrackr/domain/entities/employee.dart';

/// Abstract class representing the employee repository.
/// This class defines the methods for handling employee-related operations.
abstract class EmployeeRepository {
  /// Loads the employee details.
  /// Returns an [Employee] object if the details are successfully loaded.
  Future<Employee> loadEmployee();

  /// Updates the employee details.
  /// Takes the employee name, email, and contact number as parameters.
  /// Returns an [Employee] object if the update is successful.
  Future<Employee> updateEmployee(
      String employeeName, String employeeEmail, String employeeContactNumber);
  
}
