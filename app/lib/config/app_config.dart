class AppConfig {
  static const String baseUrl = 'http://localhost:8000/api/v1';
  static const String authLogin = '$baseUrl/auth/login';
  static const String authSignup = '$baseUrl/auth/signup';
  static const String authLogout = '$baseUrl/auth/logout';
  static const String authForgotPassword = '$baseUrl/auth/forgot-password';
}