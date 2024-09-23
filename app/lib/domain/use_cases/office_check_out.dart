import 'package:geotrackr/data/services/attendance_service.dart';

/// This class handles the office check-out process.
class OfficeCheckOut {
  final AttendanceService attendanceService;

  /// Constructor for [OfficeCheckOut].
  /// It initializes the class with the given [AttendanceService].
  OfficeCheckOut({
    required this.attendanceService,
  });

  /// Initiates the office check-out process.
  /// Returns a response message indicating the result of the check-out.
  Future<String> call() async {
    return await attendanceService.officeCheckOut();
  }
}