import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/repositories/employee_repository.dart';

class CheckLoginStatus {
  final EmployeeRepository authRepository;

  CheckLoginStatus(this.authRepository);

  Future<Employee> call() async {
    return await authRepository.loadEmployee();
  }
}
