import 'package:geotrackr/domain/entities/attendance.dart';

class OfficeEmployee {
  final String employeeId;
  final String employeeName;
  final String employeeEmail;
  final String? employeeContactNumber;
  final String? verificationCode;
  final List<String> role;
  final List<Attendances>? attendances;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String officeId;

  OfficeEmployee({
    required this.employeeId,
    required this.employeeName,
    required this.employeeEmail,
    this.employeeContactNumber,
    this.verificationCode,
    required this.role,
    this.attendances,
    this.createdAt,
    this.updatedAt,
    required this.officeId,
  });

  factory OfficeEmployee.fromJson(Map<String, dynamic> json) {
    return OfficeEmployee(
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      employeeEmail: json['employeeEmail'],
      employeeContactNumber: json['employeeContactNumber'],
      verificationCode: json['verificationCode'],
      role: List<String>.from(json['role']),
      attendances: json['attendance'] != null
          ? List<Attendances>.from(
              json['attendance'].map((x) => Attendances.fromJson(x)))
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      officeId: json['officeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'employeeEmail': employeeEmail,
      'employeeContactNumber': employeeContactNumber,
      'verificationCode': verificationCode,
      'role': role,
      'attendance': attendances?.map((x) => x.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'officeId': officeId,
    };
  }
}
