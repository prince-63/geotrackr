class ApiConfig {
  // Base URL
  static const String baseUrl = 'http://192.168.0.186:8000/api/v1';

  // login
  static const String authLogin = '$baseUrl/auth/login';

  // signup
  static const String authSignup = '$baseUrl/auth/signup';

  // verify email
  static const String verifyEmail = '$baseUrl/auth/verify-email';

  // resend verification email
  static const String resendVerificationEmail =
      '$baseUrl/auth/resend-verification-email';

  // logout
  static const String authLogout = '$baseUrl/auth/logout';

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

  // set attendence
  static const String setAttendence = '$baseUrl/attendance/set-attendance';
}
