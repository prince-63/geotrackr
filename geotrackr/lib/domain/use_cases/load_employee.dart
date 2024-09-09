import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

class LoadEmployee {
  final EmployeeRepository _employeeRepository;

  LoadEmployee(this._employeeRepository);

  Future<Employee> call() async {
    return await _employeeRepository.loadEmployee();
  }
}
