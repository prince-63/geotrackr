import 'package:geotrackr/domain/repositories/employee_repository.dart';

class UploadProfileImage {
  final EmployeeRepository employeeRepository;

  UploadProfileImage(this.employeeRepository);

  Future<String> call(
      Stream<List<int>> stream, int length, String filePath) async {
    return await employeeRepository.uploadProfileImage(
        stream, length, filePath);
  }
}
