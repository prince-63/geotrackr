import 'package:geotrackr/domain/entities/location.dart';

/// Abstract class representing the location repository.
/// This class defines the methods for handling location-related operations.
abstract class LocationRepository {
  /// Gets the current location of the device.
  /// Throws an exception if location services are disabled or permissions are denied.
  Future<Location> getLocation();

  /// Calculates the distance between two locations.
  /// Returns the distance in meters.
  Future<double> getDistanceBetween(Location location1, Location location2);
}