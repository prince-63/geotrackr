import 'package:geotrackr/domain/entities/attendance.dart';

abstract class AttendanceRepository {
  Future<String> checkIn(String longitude, String latitude);
  Future<String> checkOut(String longitude, String latitude);
  Future<List<Attendance>> loadAttendances();
}
