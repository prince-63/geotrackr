import 'package:geotrackr/domain/entities/attendance.dart';

class AttendanceModel extends Attendances {
  AttendanceModel({
    super.attendanceId,
    super.employeeId,
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
