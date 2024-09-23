import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:geotrackr/domain/repositories/attendance_repository.dart';

/// This class handles the loading of attendance records.
class LoadAttendances {
  final AttendanceRepository attendanceRepository;

  /// Constructor for [LoadAttendances].
  /// It initializes the class with the given [AttendanceRepository].
  LoadAttendances(this.attendanceRepository);

  /// Loads the attendance records.
  /// Returns a list of [Attendance] objects.
  Future<List<Attendance>> call() async {
    return await attendanceRepository.loadAttendances();
  }
}