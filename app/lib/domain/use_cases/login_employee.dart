import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

/// This class handles the login and loading of employee details.
class LoginEmployee {
  final EmployeeRepository _repository;

  /// Constructor for [LoginEmployee].
  /// It initializes the class with the given [EmployeeRepository].
  LoginEmployee(this._repository);

  /// Logs in the employee using the provided email and password.
  /// Returns an [Employee] object if the login is successful.
  Future<Employee> call(String email, String password) async {
    return await _repository.login(email, password);
  }

  /// Loads the employee details.
  /// Returns an [Employee] object if the details are successfully loaded.
  Future<Employee> loadEmployee() async {
    return await _repository.loadEmployee();
  }
}