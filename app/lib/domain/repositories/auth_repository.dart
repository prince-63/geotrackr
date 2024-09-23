import 'package:geotrackr/domain/entities/employee.dart';

/// Abstract class for AuthRepository
/// This class defines the methods for handling authentication-related operations.
abstract class AuthRepository {
  /// Logs in the employee using the provided email and password.
  /// Returns an [Employee] object if the login is successful.
  Future<Employee> login(String email, String password);

  /// Sends a password reset email to the employee.
  /// Returns an [Employee] object if the email is successfully sent.
  Future<void> forgotPassword(String email);

  /// Verifies the password reset code.
  /// Returns a boolean value indicating whether the code is valid.
  Future<bool> verifyForgotPasswordCode(String code);

  /// updates the employee password.
  /// Returns an [Employee] object if the update is successful.
  Future<void> setNewPassword(String newPassword);
}
