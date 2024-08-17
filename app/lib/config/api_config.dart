class ApiConfig {
  static const String baseUrl = 'http://192.168.0.186:8000/api/v1';
  static const String authLogin = '$baseUrl/auth/login';
  static const String authSignup = '$baseUrl/auth/signup';
  static const String verifyEmail = '$baseUrl/auth/verify-email';
  static const String resendVerificationEmail =
      '$baseUrl/auth/resend-verification-email';
  static const String authLogout = '$baseUrl/auth/logout';
  static const String authForgotPassword = '$baseUrl/auth/forgot-password';
  static const String authForgotPasswordVerification =
      '$baseUrl/auth//forgot-password/verification';
  static const String authSetNewPassword =
      '$baseUrl/auth/forgot-password/set-new-password';

  static const String setAttendence = '$baseUrl/attendance/set-attendance';
}
