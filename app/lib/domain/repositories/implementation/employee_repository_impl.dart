import 'dart:convert';
import 'package:geotrackr/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of the [EmployeeRepository] interface.
/// This class handles employee-related operations such as login, loading, and updating employee details.
class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl();

  /// Loads the employee details.
  /// Returns an [Employee] object if the details are successfully loaded.
  @override
  Future<Employee> loadEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Check for cached employee details
    // final cachedData = prefs.getString('employeeDetails');
    // if (cachedData != null) {
    //   final responseData = jsonDecode(cachedData);
    //   return Employee.fromJson(responseData);
    // }

    final response = await http.get(
      Uri.parse(ApiConfig.employeeDetails),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Cache employee details
      prefs.setString(
          'employeeDetails', jsonEncode(responseData['data']['employee']));
      return Employee.fromJson(responseData['data']['employee']);
    } else {
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
      // First clear the cache
      prefs.remove('employeeDetails');
      prefs.setString(
          'employeeDetails', jsonEncode(responseData['data']['employee']));
      return Employee.fromJson(responseData['data']['employee']);
    } else {
      throw Exception('Failed to update employee details');
    }
  }

  @override
  Future<String> uploadProfileImage(
      Stream<List<int>> stream, int length, String filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConfig.uploadProfileImage));
    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(http.MultipartFile(
      'file',
      stream,
      length,
      filename: filePath,
      contentType: MediaType('image', 'jpeg'),
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString())['message'];
    } else {
      throw Exception('Failed to upload profile image');
    }
  }
}
