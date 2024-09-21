import 'package:geotrackr/data/services/attendance_service.dart';

/// This class handles the remote check-in process.
class RemoteCheckIn {
  final AttendanceService attendanceService;

  /// Constructor for [RemoteCheckIn].
  /// It initializes the class with the given [AttendanceService].
  RemoteCheckIn({
    required this.attendanceService,
  });

  /// Initiates the remote check-in process.
  /// Returns a response message indicating the result of the check-in.
  Future<String> call() async {
    return await attendanceService.remoteCheckIn();
  }
}