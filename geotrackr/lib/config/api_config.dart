class ApiConfig {
  static const String baseUrl = 'http://192.168.0.186:8000/api/v1/office';

  static const String employeeLogin = '$baseUrl/login-employee';

  static const String employeeDetails = '$baseUrl/get-employee-details';

  static const String updateEmployeeDetails =
      '$baseUrl/update-employee-details';

  static const String officeDetails = '$baseUrl/get-office-details';
}
