import 'package:geotrackr/domain/entities/employee.dart';

/// This class represents the model for employee data.
/// It extends the [Employee] entity and inherits its properties.
class EmployeeModel extends Employee {
  /// Constructor for [EmployeeModel].
  /// It initializes the employee model with the given parameters.
  EmployeeModel({
    super.employeeId, // The unique identifier for the employee.
    super.employeeName, // The name of the employee.
    super.employeeEmail, // The email address of the employee.
    super.employeeContactNumber, // The contact number of the employee.
    super.employeeProfileImageUrl, // The profile image URL of the employee.
    super.verificationCode, // The verification code for the employee.
    super.roles, // The roles assigned to the employee.
    super.attendances, // The attendance records of the employee.
    super.officeId, // The office ID associated with the employee.
    super.isVerified, // Whether the employee is verified.
    super.biometricEnabled, // Whether biometric authentication is enabled for the employee.
  });
}
