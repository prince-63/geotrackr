import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

class LoginEmployee {
  final EmployeeRepository _repository;

  LoginEmployee(this._repository);

  Future<Employee> call(String email, String password) async {
    return await _repository.login(email, password);
  }
}
