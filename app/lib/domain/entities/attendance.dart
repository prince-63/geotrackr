/// This class represents an attendance record.
/// It includes details such as check-in and check-out times, locations, and status.
class Attendance {
  final String?
      attendanceId; // The unique identifier for the attendance record.
  final DateTime? date; // The date of the attendance.
  final DateTime? checkInTime; // The check-in time for the attendance.
  final String?
      checkInLocationLongitude; // The longitude of the check-in location.
  final String?
      checkInLocationLatitude; // The latitude of the check-in location.
  final DateTime? checkOutTime; // The check-out time for the attendance.
  final String?
      checkOutLocationLongitude; // The longitude of the check-out location.
  final String?
      checkOutLocationLatitude; // The latitude of the check-out location.
  final String? status; // The status of the attendance (e.g., present, absent).
  final String? totalHours; // The total hours worked.

  /// Constructor for [Attendance].
  /// It initializes the attendance record with the given parameters.
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

  /// Factory constructor to create an [Attendance] instance from a JSON map.
  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendanceId:
          json['attendanceId'], // The unique identifier from the JSON map.
      date: DateTime.parse(json['date']), // The date from the JSON map.
      checkInTime: DateTime.parse(
          json['checkInTime']), // The check-in time from the JSON map.
      checkInLocationLongitude: json[
          'checkInLocationLongitude'], // The check-in longitude from the JSON map.
      checkInLocationLatitude: json[
          'checkInLocationLatitude'], // The check-in latitude from the JSON map.
      checkOutTime: DateTime.parse(
          json['checkOutTime']), // The check-out time from the JSON map.
      checkOutLocationLongitude: json[
          'checkOutLocationLongitude'], // The check-out longitude from the JSON map.
      checkOutLocationLatitude: json[
          'checkOutLocationLatitude'], // The check-out latitude from the JSON map.
      status: json['status'], // The status from the JSON map.
      totalHours: json['totalHours'], // The total hours from the JSON map.
    );
  }

  /// Converts the [Attendance] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'attendanceId': attendanceId, // The unique identifier of the attendance.
      'date': date?.toIso8601String(), // The date of the attendance.
      'checkInTime': checkInTime
          ?.toIso8601String(), // The check-in time of the attendance.
      'checkInLocationLongitude':
          checkInLocationLongitude, // The check-in longitude of the attendance.
      'checkInLocationLatitude':
          checkInLocationLatitude, // The check-in latitude of the attendance.
      'checkOutTime': checkOutTime
          ?.toIso8601String(), // The check-out time of the attendance.
      'checkOutLocationLongitude':
          checkOutLocationLongitude, // The check-out longitude of the attendance.
      'checkOutLocationLatitude':
          checkOutLocationLatitude, // The check-out latitude of the attendance.
      'status': status, // The status of the attendance.
      'totalHours': totalHours, // The total hours worked.
    };
  }
}
