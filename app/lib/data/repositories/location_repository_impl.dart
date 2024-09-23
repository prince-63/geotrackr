import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/repositories/location_repository.dart';

/// Implementation of the [LocationRepository] interface.
/// This class handles location-related operations using the [Geolocator] package.
class LocationRepositoryImpl implements LocationRepository {
  /// Gets the current location of the device.
  /// Throws an exception if location services are disabled or permissions are denied.
  @override
  Future<Location> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return an error or handle accordingly
      throw Exception('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return an error or handle accordingly
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, return an error or handle accordingly
      throw Exception('Location permissions are permanently denied.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    // Return the location as a custom Location object
    return Location(
      latitude: position.latitude, // The latitude of the current location.
      longitude: position.longitude, // The longitude of the current location.
    );
  }

  /// Calculates the distance between two locations.
  /// Returns the distance in meters.
  @override
  Future<double> getDistanceBetween(
      Location location1, Location location2) async {
    return Geolocator.distanceBetween(
      location1.latitude, // The latitude of the first location.
      location1.longitude, // The longitude of the first location.
      location2.longitude, // The longitude of the second location.
      location2.latitude, // The latitude of the second location.
    );
  }
}
