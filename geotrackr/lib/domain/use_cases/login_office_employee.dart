import 'package:geotrackr/domain/entities/office_employee.dart';
import 'package:geotrackr/domain/repositories/office_employee_repository.dart';

class LoginOfficeEmployee {
  final OfficeEmployeeRepository repository;

  LoginOfficeEmployee(this.repository);

  Future<OfficeEmployee> call(String email, String password) async {
    return await repository.login(email, password);
  }
}