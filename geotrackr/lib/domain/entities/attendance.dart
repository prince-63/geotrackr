class Attendances {
  final String attendanceId;
  final String employeeId;
  final DateTime? date;
  final DateTime? checkInTime;
  final String? checkInLocation;
  final DateTime? checkOutTime;
  final String? checkOutLocation;
  final String? status;
  final String? totalHours;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Attendances({
    required this.attendanceId,
    required this.employeeId,
    this.date,
    this.checkInTime,
    this.checkInLocation,
    this.checkOutTime,
    this.checkOutLocation,
    this.status,
    this.totalHours,
    this.createdAt,
    this.updatedAt,
  });

  factory Attendances.fromJson(Map<String, dynamic> json) {
    return Attendances(
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
