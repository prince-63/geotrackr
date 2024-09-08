import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geotrackr/domain/entities/office_employee.dart';
import 'package:geotrackr/domain/repositories/office_employee_repository.dart';

class OfficeEmployeeRepositoryImpl implements OfficeEmployeeRepository {
  final String baseUrl;

  OfficeEmployeeRepositoryImpl(this.baseUrl);

  @override
  Future<OfficeEmployee> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/office_employees/login'),
      headers: {'Content-Type': 'application/json'},
      body: {'employeeEmail': email, 'employeePassword': password},
    );

    if (response.statusCode == 200) {
      return OfficeEmployee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
