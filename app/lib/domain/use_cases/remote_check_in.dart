import 'package:geotrackr/data/services/attendance_service.dart';

class RemoteCheckIn {
  final AttendanceService attendanceService;

  RemoteCheckIn({
    required this.attendanceService,
  });

  Future<double> call() async {
    return await attendanceService.remoteCheckIn();
  }
}
