import 'package:geotrackr/domain/entities/employee.dart';

class EmployeeModel extends Employee {
  EmployeeModel({
    super.employeeId,
    super.employeeName,
    super.employeeEmail,
    super.employeeContactNumber,
    super.employeeProfileImageUrl,
    super.verificationCode,
    super.roles,
    super.attendances,
    super.officeId,
    super.isVerified,
    super.biometricEnabled,
  });
}
