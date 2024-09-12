class ApiConfig {
  //========================== Base Url ==========================//
  static const String baseUrl = 'http://192.168.0.186:8000/api/v1/office';

  //========================== Employee Endpoints ==========================//
  static const String employeeLogin = '$baseUrl/login-employee';

  static const String employeeDetails = '$baseUrl/get-employee-details';

  static const String updateEmployeeDetails =
      '$baseUrl/update-employee-details';

  static const String officeDetails = '$baseUrl/get-office-details';

  //========================== Attendance Endpoints ==========================//
  static const String checkIn = '$baseUrl/employee/check-in';

  static const String checkOut = '$baseUrl/employee/check-out';

  static const String getAttendances = '$baseUrl/employee/attendances';
}
