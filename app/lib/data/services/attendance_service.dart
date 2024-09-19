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

  // Distance threshold in meters for checking in/out
  static const double distanceThreshold = 200.0;
  final Logger _logger = Logger();

  AttendanceService({
    required this.attendanceRepository,
    required this.locationRepository,
    required this.biometricRepository,
    required this.officeRepository,
  });

  // Method to handle office check-in
  Future<double> officeCheckIn() async {
    try {
      // Authenticate the user using biometric authentication
      bool isAuthenticated = await biometricRepository.authenticate();

      if (!isAuthenticated) {
        _logger.w('Biometric authentication failed.');
        return -1; // Return -1 if authentication fails
      }

      // Get the current location of the user
      Location location = await locationRepository.getLocation();
      _logger.i('Location: ${location.latitude}, ${location.longitude}');

      // Round the latitude and longitude to six decimal places
      final currentLocationLongitude = roundToSixDecimals(location.longitude);
      final currentLocationLatitude = roundToSixDecimals(location.latitude);

      // Load the office location details
      Office office = await officeRepository.loadOffice();

      if (office.officeLatitude != null && office.officeLongitude != null) {
        // Convert office location from String to double
        double officeLocationLongitude =
            convertStringToDouble(office.officeLongitude!);
        double officeLocationLatitude =
            convertStringToDouble(office.officeLatitude!);

        // Calculate the distance between the current location and the office location
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

        // Check if the distance is greater than the threshold
        if (distance > distanceThreshold) {
          _logger.w(
              'Distance to office is greater than $distanceThreshold meters: $distance meters.');
          return distance; // Return the distance if it's greater than the threshold
        }

        // Check-in the user if the distance is within the threshold
        await attendanceRepository.checkIn(
          currentLocationLongitude.toString(),
          currentLocationLatitude.toString(),
        );
        _logger.i('Check-in successful.');
      }
      return 0; // Return 0 if check-in is successful
    } catch (e) {
      _logger.e('Error during check-in: $e');
      return -1; // Return -1 if an error occurs
    }
  }

  // Method to handle office check-out
  Future<double> officeCheckOut() async {
    try {
      // Authenticate the user using biometric authentication
      bool isAuthenticated = await biometricRepository.authenticate();

      if (!isAuthenticated) {
        _logger.w('Biometric authentication failed.');
        return -1; // Return -1 if authentication fails
      }

      // Get the current location of the user
      Location location = await locationRepository.getLocation();
      _logger.i('Location: ${location.latitude}, ${location.longitude}');

      // Round the latitude and longitude to six decimal places
      final currentLocationLongitude = roundToSixDecimals(location.longitude);
      final currentLocationLatitude = roundToSixDecimals(location.latitude);

      // Load the office location details
      Office office = await officeRepository.loadOffice();

      if (office.officeLatitude != null && office.officeLongitude != null) {
        // Convert office location from String to double
        double officeLocationLongitude =
            convertStringToDouble(office.officeLongitude!);
        double officeLocationLatitude =
            convertStringToDouble(office.officeLatitude!);

        // Calculate the distance between the current location and the office location
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

        // Check if the distance is less than the threshold
        if (distance < distanceThreshold) {
          _logger.w(
              'Distance to office is less than $distanceThreshold meters: $distance meters.');
          return distance; // Return the distance if it's less than the threshold
        }

        // Check-out the user if the distance is greater than the threshold
        await attendanceRepository.checkOut(
          currentLocationLongitude.toString(),
          currentLocationLatitude.toString(),
        );
        _logger.i('Check-out successful.');
      }
      return 0; // Return 0 if check-out is successful
    } catch (e) {
      _logger.e('Error during check-out: $e');
      return -1; // Return -1 if an error occurs
    }
  }

  // Method to handle remote check-in
  Future<double> remoteCheckIn() async {
    try {
      // Authenticate the user using biometric authentication
      bool isAuthenticated = await biometricRepository.authenticate();

      if (!isAuthenticated) {
        _logger.w('Biometric authentication failed.');
        return -1; // Return -1 if authentication fails
      }

      // Get the current location of the user
      Location location = await locationRepository.getLocation();
      _logger.i('Location: ${location.latitude}, ${location.longitude}');

      // Check-in the user
      await attendanceRepository.checkIn(
        location.longitude.toString(),
        location.latitude.toString(),
      );
      _logger.i('Remote check-in successful.');
      return 0; // Return 0 if check-in is successful
    } catch (e) {
      _logger.e('Error during remote check-in: $e');
      return -1; // Return -1 if an error occurs
    }
  }

  Future<double> remoteCheckOut() async {
    try {
      // Authenticate the user using biometric authentication
      bool isAuthenticated = await biometricRepository.authenticate();

      if (!isAuthenticated) {
        _logger.w('Biometric authentication failed.');
        return -1; // Return -1 if authentication fails
      }

      // Get the current location of the user
      Location location = await locationRepository.getLocation();
      _logger.i('Location: ${location.latitude}, ${location.longitude}');

      // Check-out the user
      await attendanceRepository.checkOut(
        location.longitude.toString(),
        location.latitude.toString(),
      );
      _logger.i('Remote check-out successful.');
      return 0; // Return 0 if check-out is successful
    } catch (e) {
      _logger.e('Error during remote check-out: $e');
      return -1; // Return -1 if an error occurs
    }
  }

  // Helper method to convert a String to double
  static double convertStringToDouble(String data) {
    return double.parse(data);
  }

  // Helper method to round a double value to six decimal places
  static double roundToSixDecimals(double value) {
    return double.parse(value.toStringAsFixed(6));
  }
}
