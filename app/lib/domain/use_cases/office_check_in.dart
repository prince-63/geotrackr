import 'package:geotrackr/data/services/attendance_service.dart';

class OfficeCheckIn {
  final AttendanceService attendanceService;

  OfficeCheckIn({
    required this.attendanceService,
  });

  Future<String> call() async {
    return await attendanceService.officeCheckIn();
  }
}
