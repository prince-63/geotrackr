import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

class LoadEmployee {
  final EmployeeRepository employeeRepository;

  LoadEmployee({required this.employeeRepository});

  Future<Employee> call() async {
    return await employeeRepository.loadEmployee();
  }
}
