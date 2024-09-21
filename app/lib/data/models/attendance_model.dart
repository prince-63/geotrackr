import 'package:geotrackr/domain/entities/attendance.dart';

/// This class represents the model for attendance data.
/// It extends the [Attendance] entity and inherits its properties.
class AttendanceModel extends Attendance {
  /// Constructor for [AttendanceModel].
  /// It initializes the attendance model with the given parameters.
  AttendanceModel({
    super.attendanceId, // The unique identifier for the attendance record.
    super.date, // The date of the attendance.
    super.checkInTime, // The check-in time for the attendance.
    super.checkInLocationLongitude, // The longitude of the check-in location.
    super.checkInLocationLatitude, // The latitude of the check-in location.
    super.checkOutTime, // The check-out time for the attendance.
    super.checkOutLocationLongitude, // The longitude of the check-out location.
    super.checkOutLocationLatitude, // The latitude of the check-out location.
    super.status, // The status of the attendance (e.g., present, absent).
    super.totalHours, // The total hours worked.
  });
}