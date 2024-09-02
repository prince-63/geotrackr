class ApiConfig {
  // Base URL
  static const String baseUrl = 'http://192.168.0.186:8000/api/v1';

  // get office location coordinates
  static const String getOfficeLocationCoordinates =
      '$baseUrl/office/get-office-location';

  // join as in office employee
  static const String joinAsInOfficeEmployee =
      '$baseUrl/office/in-office/employee-join';

  // get in office employee detail
  static const String getInOfficeEmployeeDetail =
      '$baseUrl/office/in-office/get-employee-detail';

  // check-in attendance for in office employee
  static const String checkInAttendanceInOfficeEmployee =
      '$baseUrl/office/in-office/attendance/check-in';

  // check-out attendance for in office employee
  static const String checkOutAttendanceInOfficeEmployee =
      '$baseUrl/office/in-office/attendance/check-out';

  // join as out office employee
  static const String joinAsOutOfficeEmployee =
      '$baseUrl/office/out-office/employee-join';

  // get out office employee detail
  static const String getOutOfficeEmployeeDetail =
      '$baseUrl/office/out-office/get-employee-detail';

  // check-in attendance for out office employee
  static const String checkInAttendanceOutOfficeEmployee =
      '$baseUrl/office/out-office/attendance/check-in';

  // check-out attendance for out office employee
  static const String checkOutAttendanceOutOfficeEmployee =
      '$baseUrl/office/out-office/attendance/check-out';

  // login
  static const String authLogin = '$baseUrl/auth/login';

  // signup
  static const String authSignup = '$baseUrl/auth/signup';

  // logout
  static const String authLogout = '$baseUrl/auth/logout';

  // close account
  static const String authCloseAccount = '$baseUrl/auth/close-account';

  // verify email
  static const String verifyEmail = '$baseUrl/auth/verify-email';

  // resend verification email
  static const String resendVerificationEmail =
      '$baseUrl/auth/resend-verification-email';

  // forgot password
  static const String authForgotPassword = '$baseUrl/auth/forgot-password';

  // forgot password verification
  static const String authForgotPasswordVerification =
      '$baseUrl/auth//forgot-password/verification';

  // set new password
  static const String authSetNewPassword =
      '$baseUrl/auth/forgot-password/set-new-password';

  // get user profile
  static const String uploadProfileImage =
      '$baseUrl/profile/upload/profile-picture';

  // upload profile details
  static const String uploadProfileDetails =
      '$baseUrl/profile/upload/profile-details';

  // get user profile
  static const String getUserProfile = '$baseUrl/profile/get-profile-details';

  // set attendence
  static const String setAttendence = '$baseUrl/attendance/set-attendance';

  // download id card
  static const String downloadIdCard = '$baseUrl/id-card/generate-id-card';

  // get organization location
  static const String getOrganizationLocation =
      '$baseUrl/location/get-organization-location';

  // check in attendance
  static const String checkInAttendance = '$baseUrl/attendance/check-in';

  // check out attendance
  static const String checkOutAttendance = '$baseUrl/attendance/check-out';

  // get attendance
  static const String getUserAttendance =
      '$baseUrl/attendance/get-user-attendance';
}
