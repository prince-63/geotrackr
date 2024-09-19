import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/entities/office.dart';
import 'package:geotrackr/domain/repositories/attendance_repository.dart';
import 'package:geotrackr/domain/repositories/biometric_repository.dart';
import 'package:geotrackr/domain/repositories/location_repository.dart';
import 'package:geotrackr/domain/repositories/office_repository.dart';
import 'package:logger/logger.dart';

class AttendanceService {
  final AttendanceRepository attendanceRepository;
  final LocationRepository locationRepository;
  final BiometricRepository biometricRepository;
  final OfficeRepository officeRepository;

  static const double distanceThreshold = 200.0;
  final Logger _logger = Logger();

  AttendanceService({
    required this.attendanceRepository,
    required this.locationRepository,
    required this.biometricRepository,
    required this.officeRepository,
  });

  Future<String> officeCheckIn() async {
    late String responseMessage;
    try {
      bool isAuthenticated = await biometricRepository.authenticate();

      if (!isAuthenticated) {
        _logger.w('Biometric authentication failed.');
        return 'Biometric authentication failed.';
      }

      Location location = await locationRepository.getLocation();
      _logger.i('Location: ${location.latitude}, ${location.longitude}');

      final currentLocationLongitude = roundToSixDecimals(location.longitude);
      final currentLocationLatitude = roundToSixDecimals(location.latitude);

      Office office = await officeRepository.loadOffice();

      if (office.officeLatitude != null && office.officeLongitude != null) {
        double officeLocationLongitude =
            convertStringToDouble(office.officeLongitude!);
        double officeLocationLatitude =
            convertStringToDouble(office.officeLatitude!);

        double distance = await locationRepository.getDistanceBetween(
          Location(
            latitude: currentLocationLatitude,
            longitude: currentLocationLongitude,
          ),
          Location(
            latitude: officeLocationLatitude,
            longitude: officeLocationLongitude,
          ),
        );

        if (distance > distanceThreshold) {
          _logger.w(
              'Distance to office is greater than $distanceThreshold meters: $distance meters.');
          return 'Distance to office is greater than $distanceThreshold meters: $distance meters.';
        }

        responseMessage = await attendanceRepository.checkIn(
          currentLocationLongitude.toString(),
          currentLocationLatitude.toString(),
        );
      }
      return responseMessage;
    } catch (e) {
      _logger.e('Error during check-in: $e');
      return e.toString();
    }
  }

  Future<String> officeCheckOut() async {
    late String responseMessage;
    try {
      bool isAuthenticated = await biometricRepository.authenticate();

      if (!isAuthenticated) {
        _logger.w('Biometric authentication failed.');
        return 'Biometric authentication failed.';
      }

      Location location = await locationRepository.getLocation();
      _logger.i('Location: ${location.latitude}, ${location.longitude}');

      final currentLocationLongitude = roundToSixDecimals(location.longitude);
      final currentLocationLatitude = roundToSixDecimals(location.latitude);

      Office office = await officeRepository.loadOffice();

      if (office.officeLatitude != null && office.officeLongitude != null) {
        double officeLocationLongitude =
            convertStringToDouble(office.officeLongitude!);
        double officeLocationLatitude =
            convertStringToDouble(office.officeLatitude!);

        double distance = await locationRepository.getDistanceBetween(
          Location(
            latitude: currentLocationLatitude,
            longitude: currentLocationLongitude,
          ),
          Location(
            latitude: officeLocationLatitude,
            longitude: officeLocationLongitude,
          ),
        );

        if (distance < distanceThreshold) {
          _logger.w(
              'Distance to office is less than $distanceThreshold meters: ${distance.toStringAsFixed(2)} meters.');
          return 'Distance to office is less than $distanceThreshold meters: ${distance.toStringAsFixed(2)} meters.';
        }

        responseMessage = await attendanceRepository.checkOut(
          currentLocationLongitude.toString(),
          currentLocationLatitude.toString(),
        );
      }
      return responseMessage;
    } catch (e) {
      _logger.e('Error during check-out: $e');
      return e.toString();
    }
  }

  Future<String> remoteCheckIn() async {
    late String responseMessage;
    try {
      bool isAuthenticated = await biometricRepository.authenticate();

      if (!isAuthenticated) {
        _logger.w('Biometric authentication failed.');
        return 'Biometric authentication failed.';
      }

      Location location = await locationRepository.getLocation();
      _logger.i('Location: ${location.latitude}, ${location.longitude}');

      responseMessage = await attendanceRepository.checkIn(
        location.longitude.toString(),
        location.latitude.toString(),
      );
      return responseMessage;
    } catch (e) {
      _logger.e('Error during remote check-in: $e');
      return e.toString();
    }
  }

  Future<String> remoteCheckOut() async {
    late String responseMessage;
    try {
      bool isAuthenticated = await biometricRepository.authenticate();

      if (!isAuthenticated) {
        _logger.w('Biometric authentication failed.');
        return 'Biometric authentication failed.';
      }

      Location location = await locationRepository.getLocation();
      _logger.i('Location: ${location.latitude}, ${location.longitude}');

      responseMessage = await attendanceRepository.checkOut(
        location.longitude.toString(),
        location.latitude.toString(),
      );
      return responseMessage;
    } catch (e) {
      _logger.e('Error during remote check-out: $e');
      return e.toString();
    }
  }

  static double convertStringToDouble(String data) {
    return double.parse(data);
  }

  static double roundToSixDecimals(double value) {
    return double.parse(value.toStringAsFixed(6));
  }
}