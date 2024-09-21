import 'package:geotrackr/domain/entities/attendance.dart';

/// This class represents an employee.
/// It includes details such as name, email, contact number, and attendance records.
class Employee {
  final String? employeeId; // The unique identifier for the employee.
  final String? employeeName; // The name of the employee.
  final String? employeeEmail; // The email address of the employee.
  final String? employeeContactNumber; // The contact number of the employee.
  final String? verificationCode; // The verification code for the employee.
  final String?
      employeeProfileImageUrl; // The profile image URL of the employee.
  final bool? isVerified; // Whether the employee is verified.
  final bool?
      biometricEnabled; // Whether biometric authentication is enabled for the employee.
  final List<String>? roles; // The roles assigned to the employee.
  final List<Attendance>?
      attendances; // The attendance records of the employee.
  final String? officeId; // The office ID associated with the employee.

  /// Constructor for [Employee].
  /// It initializes the employee with the given parameters.
  Employee({
    this.employeeId,
    this.employeeName,
    this.employeeEmail,
    this.employeeContactNumber,
    this.employeeProfileImageUrl,
    this.verificationCode,
    this.roles,
    this.attendances,
    this.officeId,
    this.isVerified,
    this.biometricEnabled,
  });

  /// Factory constructor to create an [Employee] instance from a JSON map.
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeId:
          json['employeeId'], // The unique identifier from the JSON map.
      employeeName: json['employeeName'], // The name from the JSON map.
      employeeEmail:
          json['employeeEmail'], // The email address from the JSON map.
      employeeContactNumber: json[
          'employeeContactNumber'], // The contact number from the JSON map.
      employeeProfileImageUrl: json[
          'employeeProfileImageUrl'], // The profile image URL from the JSON map.
      verificationCode:
          json['verificationCode'], // The verification code from the JSON map.
      roles: List<String>.from(json['roles']), // The roles from the JSON map.
      attendances: List.from(json['attendances'])
          .map((e) => Attendance.fromJson(e))
          .toList(), // The attendance records from the JSON map.
      officeId: json['officeId'], // The office ID from the JSON map.
      isVerified:
          json['isVerified'], // The verification status from the JSON map.
      biometricEnabled:
          json['biometricEnabled'], // The biometric status from the JSON map.
    );
  }

  /// Converts the [Employee] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId, // The unique identifier of the employee.
      'employeeName': employeeName, // The name of the employee.
      'employeeEmail': employeeEmail, // The email address of the employee.
      'employeeContactNumber':
          employeeContactNumber, // The contact number of the employee.
      'employeeProfileImageUrl':
          employeeProfileImageUrl, // The profile image URL of the employee.
      'verificationCode':
          verificationCode, // The verification code of the employee.
      'roles': roles, // The roles assigned to the employee.
      'attendances': attendances
          ?.map((e) => e.toJson())
          .toList(), // The attendance records of the employee.
      'officeId': officeId, // The office ID associated with the employee.
      'isVerified': isVerified, // The verification status of the employee.
      'biometricEnabled':
          biometricEnabled, // The biometric status of the employee.
    };
  }
}
