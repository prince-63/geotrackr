import 'package:geotrackr/data/services/attendance_service.dart';

class RemoteCheckOut {
  final AttendanceService attendanceService;
  
  RemoteCheckOut({
    required this.attendanceService,
  });

  Future<String> call() async {
    return await attendanceService.remoteCheckOut();
  }
}
