import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final StreamController<Location> _locationController =
      StreamController<Location>.broadcast();
  StreamSubscription<Position>? _positionStreamSubscription;

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
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  Future<void> startLocationService() async {
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

    // Start listening to location updates
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((position) {
      // Emit the location as a custom Location object
      _locationController.add(
        Location(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    });
  }

  @override
  Future<void> stopLocationService() async {
    await _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  @override
  Stream<Location> getLocationStream() {
    return _locationController.stream;
  }
}
