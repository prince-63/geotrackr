import 'package:geotrackr/domain/entities/attendance.dart';

class AttendanceModel extends Attendances {
  AttendanceModel({
    required super.attendanceId,
    required super.employeeId,
    super.date,
    super.checkInTime,
    super.checkInLocation,
    super.checkOutTime,
    super.checkOutLocation,
    super.status,
    super.totalHours,
    super.createdAt,
    super.updatedAt,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      attendanceId: json['_id'],
      employeeId: json['employeeId'],
      date: DateTime.parse(json['date']),
      checkInTime: DateTime.parse(json['checkInTime']),
      checkInLocation: json['checkInLocation'],
      checkOutTime: DateTime.parse(json['checkOutTime']),
      checkOutLocation: json['checkOutLocation'],
      status: json['status'],
      totalHours: json['totalHours'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '_id': attendanceId,
      'employeeId': employeeId,
      'date': date?.toIso8601String(),
      'checkInTime': checkInTime?.toIso8601String(),
      'checkInLocation': checkInLocation,
      'checkOutTime': checkOutTime?.toIso8601String(),
      'checkOutLocation': checkOutLocation,
      'status': status,
      'totalHours': totalHours,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
