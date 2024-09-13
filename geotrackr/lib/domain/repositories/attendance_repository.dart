import 'package:geotrackr/domain/entities/attendance.dart';

abstract class AttendanceRepository {
  Future<bool> checkIn(String longitude, String latitude);
  Future<bool> checkOut(String longitude, String latitude);
  Future<List<Attendance>> loadAttendances();
}
