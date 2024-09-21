import 'package:geotrackr/domain/entities/attendance.dart';

/// Abstract class representing the attendance repository.
/// This class defines the methods for handling attendance-related operations.
abstract class AttendanceRepository {
  /// Handles the check-in process.
  /// Takes the longitude and latitude as parameters.
  /// Returns a response message indicating the result of the check-in.
  Future<String> checkIn(String longitude, String latitude);

  /// Handles the check-out process.
  /// Takes the longitude and latitude as parameters.
  /// Returns a response message indicating the result of the check-out.
  Future<String> checkOut(String longitude, String latitude);

  /// Loads the attendance records.
  /// Returns a list of [Attendance] objects.
  Future<List<Attendance>> loadAttendances();
}