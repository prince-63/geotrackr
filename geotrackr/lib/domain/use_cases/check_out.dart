import 'package:geotrackr/domain/repositories/attendance_repository.dart';

class CheckOut {
  final AttendanceRepository attendanceRepository;

  CheckOut(this.attendanceRepository);

  Future<bool> call(String longitude, String latitude) async {
    return await attendanceRepository.checkOut(longitude, latitude);
  }
}
