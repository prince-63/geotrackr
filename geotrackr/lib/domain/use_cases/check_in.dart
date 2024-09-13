import 'package:geotrackr/domain/repositories/attendance_repository.dart';

class CheckIn {
  final AttendanceRepository attendanceRepository;

  CheckIn(this.attendanceRepository);

  Future<bool> call(String longitude, String latitude) async {
    return await attendanceRepository.checkIn(longitude, latitude);
  }
}
