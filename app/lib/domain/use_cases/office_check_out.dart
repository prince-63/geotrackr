import 'package:geotrackr/data/services/attendance_service.dart';

class OfficeCheckOut {
  final AttendanceService attendanceService;

  OfficeCheckOut({
    required this.attendanceService,
  });

  Future<double> call() async {
    return await attendanceService.officeCheckOut();
  }
}
