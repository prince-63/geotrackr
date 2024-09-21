import 'package:geotrackr/data/services/attendance_service.dart';

/// This class handles the remote check-out process.
class RemoteCheckOut {
  final AttendanceService attendanceService;

  /// Constructor for [RemoteCheckOut].
  /// It initializes the class with the given [AttendanceService].
  RemoteCheckOut({
    required this.attendanceService,
  });

  /// Initiates the remote check-out process.
  /// Returns a response message indicating the result of the check-out.
  Future<String> call() async {
    return await attendanceService.remoteCheckOut();
  }
}