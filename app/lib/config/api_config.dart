/// This class contains the configuration for API endpoints.
/// It includes the base URL and specific endpoints for employee and attendance-related operations.
class ApiConfig {
  //========================== Base Url ==========================//
  /// The base URL for the API.
  static const String baseUrl = 'http://192.168.0.186:8000/api/v1/office';

  //========================== Employee Endpoints ==========================//
  /// Endpoint for employee login.
  static const String employeeLogin = '$baseUrl/login-employee';

  /// Endpoint to get employee details.
  static const String employeeDetails = '$baseUrl/get-employee-details';

  /// Endpoint to update employee details.
  static const String updateEmployeeDetails =
      '$baseUrl/update-employee-details';

  /// Endpoint to send password reset email.
  static const String forgotPassword = '$baseUrl/forgot-password';

  /// Endpoint to verify password reset code.
  static const String verifyForgotPasswordCode =
      '$baseUrl/verify-reset-password';

  /// Endpoint to update employee password.
  static const String updatePassword = '$baseUrl/set-new-password';

  /// Endpoint to get office details.
  static const String officeDetails = '$baseUrl/get-office-details';

  //========================== Attendance Endpoints ==========================//
  /// Endpoint for employee check-in.
  static const String checkIn = '$baseUrl/employee/check-in';

  /// Endpoint for employee check-out.
  static const String checkOut = '$baseUrl/employee/check-out';

  /// Endpoint to get employee attendances.
  static const String getAttendances = '$baseUrl/employee/attendances';
}
