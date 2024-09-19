import 'package:geotrackr/domain/entities/attendance.dart';

class AttendanceModel extends Attendance {
  AttendanceModel({
    super.attendanceId,
    super.date,
    super.checkInTime,
    super.checkInLocationLongitude,
    super.checkInLocationLatitude,
    super.checkOutTime,
    super.checkOutLocationLongitude,
    super.checkOutLocationLatitude,
    super.status,
    super.totalHours,
  });
}
