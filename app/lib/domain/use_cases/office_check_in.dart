import 'package:geotrackr/data/services/attendance_service.dart';

/// This class handles the office check-in process.
class OfficeCheckIn {
  final AttendanceService attendanceService;

  /// Constructor for [OfficeCheckIn].
  /// It initializes the class with the given [AttendanceService].
  OfficeCheckIn({
    required this.attendanceService,
  });

  /// Initiates the office check-in process.
  /// Returns a response message indicating the result of the check-in.
  Future<String> call() async {
    return await attendanceService.officeCheckIn();
  }
}