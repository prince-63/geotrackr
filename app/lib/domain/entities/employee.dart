import 'package:geotrackr/domain/entities/attendance.dart';

class Employee {
  final String? employeeId;
  final String? employeeName;
  final String? employeeEmail;
  final String? employeeContactNumber;
  final String? verificationCode;
  final String? employeeProfileImageUrl;
  final bool? isVerified;
  final bool? biometricEnabled;
  final List<String>? roles;
  final List<Attendance>? attendances;
  final String? officeId;

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

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      employeeEmail: json['employeeEmail'],
      employeeContactNumber: json['employeeContactNumber'],
      employeeProfileImageUrl: json['employeeProfileImageUrl'],
      verificationCode: json['verificationCode'],
      roles: List<String>.from(json['roles']),
      attendances: List.from(json['attendances'])
          .map((e) => Attendance.fromJson(e))
          .toList(),
      officeId: json['officeId'],
      isVerified: json['isVerified'],
      biometricEnabled: json['biometricEnabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'employeeEmail': employeeEmail,
      'employeeContactNumber': employeeContactNumber,
      'employeeProfileImageUrl': employeeProfileImageUrl,
      'verificationCode': verificationCode,
      'roles': roles,
      'attendances': attendances?.map((e) => e.toJson()).toList(),
      'officeId': officeId,
      'isVerified': isVerified,
      'biometricEnabled': biometricEnabled,
    };
  }
}
