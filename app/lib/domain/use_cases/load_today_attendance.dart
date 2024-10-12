import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:geotrackr/domain/repositories/attendance_repository.dart';

class LoadTodayAttendance {
  final AttendanceRepository attendanceRepository;

  LoadTodayAttendance(this.attendanceRepository);

  Future<Attendance> call() async {
    return await attendanceRepository.loadTodayAttendance();
  }
}
