import 'dart:convert';
import 'package:geotrackr/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl();

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
      // first clear the cache
      prefs.remove('employeeDetails');
      prefs.setString(
          'employeeDetails', jsonEncode(responseData['data']['employee']));
      return Employee.fromJson(responseData['data']['employee']);
    } else {
      print(jsonDecode(response.body));
      throw Exception('Failed to update employee details');
    }
  }
}