import 'package:geotrackr/domain/entities/employee.dart';

/// Abstract class representing the employee repository.
/// This class defines the methods for handling employee-related operations.
abstract class EmployeeRepository {
  /// Logs in the employee using the provided email and password.
  /// Returns an [Employee] object if the login is successful.
  Future<Employee> login(String email, String password);

  /// Loads the employee details.
  /// Returns an [Employee] object if the details are successfully loaded.
  Future<Employee> loadEmployee();

  /// Updates the employee details.
  /// Takes the employee name, email, and contact number as parameters.
  /// Returns an [Employee] object if the update is successful.
  Future<Employee> updateEmployee(
      String employeeName, String employeeEmail, String employeeContactNumber);

  /// Sends a password reset email to the employee.
  /// Returns an [Employee] object if the email is successfully sent.
  Future<void> forgotPassword(String email);

  /// Verifies the password reset code.
  /// Returns a boolean value indicating whether the code is valid.
  Future<bool> verifyForgotPasswordCode(String code);

  /// updates the employee password.
  /// Returns an [Employee] object if the update is successful.
  Future<void> updatePassword(String newPassword);
}