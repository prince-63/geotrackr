import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

/// This class handles the loading of employee details.
class LoadEmployee {
  final EmployeeRepository employeeRepository;

  /// Constructor for [LoadEmployee].
  /// It initializes the class with the given [EmployeeRepository].
  LoadEmployee({required this.employeeRepository});

  /// Loads the employee details.
  /// Returns an [Employee] object if the details are successfully loaded.
  Future<Employee> call() async {
    return await employeeRepository.loadEmployee();
  }
}