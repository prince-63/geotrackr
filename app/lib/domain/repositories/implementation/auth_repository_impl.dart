import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geotrackr/config/api_config.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  /// Logs in the employee using the provided email and password.
  /// Returns an [Employee] object if the login is successful.
  @override
  Future<Employee> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConfig.employeeLogin),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final String token = responseData['data']['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      return Employee.fromJson(responseData['data']['employee']);
    } else {
      print(jsonDecode(response.body));
      throw Exception('Failed to login');
    }
  }

  /// Sends a password reset email to the employee.
  @override
  Future<void> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.forgotPassword),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'employeeEmail': email,
        }),
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);

      if (response.statusCode != 200) {
        throw Exception('Failed to send password reset email');
      }

      return Future.value();
    } catch (e) {
      throw Exception('Failed to send password reset email');
    }
  }

  /// Verifies the password reset code.
  @override
  Future<bool> verifyForgotPasswordCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.verifyForgotPasswordCode),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'verificationCode': code,
          'employeeEmail': email,
        }),
      );

      if (response.statusCode == 200) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<void> setNewPassword(String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    try {
      final response = await http.put(
        Uri.parse(ApiConfig.updatePassword),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'employeePassword': newPassword,
          'employeeEmail': email,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update password');
      }

      return Future.value();
    } catch (e) {
      throw Exception('Failed to update password');
    }
  }
}
