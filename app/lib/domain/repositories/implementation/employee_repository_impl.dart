import 'dart:convert';
import 'package:geotrackr/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of the [EmployeeRepository] interface.
/// This class handles employee-related operations such as login, loading, and updating employee details.
class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl();

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

  /// Loads the employee details.
  /// Returns an [Employee] object if the details are successfully loaded.
  @override
  Future<Employee> loadEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Check for cached employee details
    final cachedData = prefs.getString('employeeDetails');
    if (cachedData != null) {
      final responseData = jsonDecode(cachedData);
      return Employee.fromJson(responseData);
    }

    final response = await http.get(
      Uri.parse(ApiConfig.employeeDetails),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(jsonEncode(responseData['data']['employee']));
      // Cache employee details
      prefs.setString(
          'employeeDetails', jsonEncode(responseData['data']['employee']));
      return Employee.fromJson(responseData['data']['employee']);
    } else {
      print(jsonDecode(response.body));
      throw Exception('Failed to get employee details');
    }
  }

  /// Updates the employee details.
  /// Takes the employee name, email, and contact number as parameters.
  /// Returns an [Employee] object if the update is successful.
  @override
  Future<Employee> updateEmployee(String employeeName, String employeeEmail,
      String employeeContactNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(ApiConfig.updateEmployeeDetails),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'employeeName': employeeName,
        'employeeEmail': employeeEmail,
        'employeeContactNumber': employeeContactNumber,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(jsonEncode(responseData['data']['employee']));
      // First clear the cache
      prefs.remove('employeeDetails');
      prefs.setString(
          'employeeDetails', jsonEncode(responseData['data']['employee']));
      return Employee.fromJson(responseData['data']['employee']);
    } else {
      print(jsonDecode(response.body));
      throw Exception('Failed to update employee details');
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
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.verifyForgotPasswordCode),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'code': code,
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
  Future<void> updatePassword(String newPassword) async {
    try {
      final response = await http.put(
        Uri.parse(ApiConfig.updatePassword),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'newPassword': newPassword,
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
