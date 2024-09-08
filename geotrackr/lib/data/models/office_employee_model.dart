import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:geotrackr/domain/entities/office_employee.dart';

class OfficeEmployeeModel extends OfficeEmployee {
  OfficeEmployeeModel(
      {required super.employeeId,
      required super.employeeName,
      required super.employeeEmail,
      super.employeeContactNumber,
      required super.role,
      super.attendances,
      super.createdAt,
      super.updatedAt,
      required super.officeId});

  factory OfficeEmployeeModel.fromJson(Map<String, dynamic> json) {
    return OfficeEmployeeModel(
      employeeId: json['_id'],
      employeeName: json['employeeName'],
      employeeEmail: json['employeeEmail'],
      employeeContactNumber: json['employeeContactNumber'],
      role: List<String>.from(json['role']),
      attendances: List.from(json['attendance'])
          .map((e) => Attendances.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      officeId: json['officeId'],
    );
  }
}
