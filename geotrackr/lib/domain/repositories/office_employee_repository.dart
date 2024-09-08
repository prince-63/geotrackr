import 'package:geotrackr/domain/entities/office_employee.dart';

abstract class OfficeEmployeeRepository {
  Future<OfficeEmployee> login(String email, String password);
}
