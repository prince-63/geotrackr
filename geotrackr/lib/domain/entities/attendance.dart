class Attendance {
  final String? attendanceId;
  final DateTime? date;
  final DateTime? checkInTime;
  final String? checkInLocationLongitude;
  final String? checkInLocationLatitude;
  final DateTime? checkOutTime;
  final String? checkOutLocationLongitude;
  final String? checkOutLocationLatitude;
  final String? status;
  final String? totalHours;

  Attendance({
    this.attendanceId,
    this.date,
    this.checkInTime,
    this.checkInLocationLongitude,
    this.checkInLocationLatitude,
    this.checkOutTime,
    this.checkOutLocationLongitude,
    this.checkOutLocationLatitude,
    this.status,
    this.totalHours,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendanceId: json['attendanceId'],
      date: DateTime.parse(json['date']),
      checkInTime: DateTime.parse(json['checkInTime']),
      checkInLocationLongitude: json['checkInLocationLongitude'],
      checkInLocationLatitude: json['checkInLocationLatitude'],
      checkOutTime: DateTime.parse(json['checkOutTime']),
      checkOutLocationLongitude: json['checkOutLocationLongitude'],
      checkOutLocationLatitude: json['checkOutLocationLatitude'],
      status: json['status'],
      totalHours: json['totalHours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendanceId': attendanceId,
      'date': date?.toIso8601String(),
      'checkInTime': checkInTime?.toIso8601String(),
      'checkInLocationLongitude': checkInLocationLongitude,
      'checkInLocationLatitude': checkInLocationLatitude,
      'checkOutTime': checkOutTime?.toIso8601String(),
      'checkOutLocationLongitude': checkOutLocationLongitude,
      'checkOutLocationLatitude': checkOutLocationLatitude,
      'status': status,
      'totalHours': totalHours,
    };
  }
}
