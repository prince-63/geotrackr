import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/auth_repository.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

/// This class handles the login and loading of employee details.
class LoginEmployee {
  final AuthRepository _repository;

  /// Constructor for [LoginEmployee].
  /// It initializes the class with the given [EmployeeRepository].
  LoginEmployee(this._repository);

  /// Logs in the employee using the provided email and password.
  /// Returns an [Employee] object if the login is successful.
  Future<Employee> call(String email, String password) async {
    return await _repository.login(email, password);
  }
}