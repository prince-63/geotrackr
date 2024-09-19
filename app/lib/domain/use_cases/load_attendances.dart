import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:geotrackr/domain/repositories/attendance_repository.dart';

class LoadAttendances {
  final AttendanceRepository attendanceRepository;

  LoadAttendances(this.attendanceRepository);

  Future<List<Attendance>> call() async {
    return await attendanceRepository.loadAttendances();
  }
}
