import 'dart:async';
import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/repositories/background_location_repository.dart';

class BackgroundLocationService {
  final BackgroundLocationRepository _backgroundLocationRepository;
  final _locationController = StreamController<Location>.broadcast();

  BackgroundLocationService(this._backgroundLocationRepository);

  Stream<Location> get locationStream => _locationController.stream;

  /// This method starts the background location service and listens to the location stream.
  Future<void> startBackgroundLocationService() async {
    await _backgroundLocationRepository.startLocationService();
    _backgroundLocationRepository.getLocationStream().listen((location) {
      _locationController.add(location);
    });
  }

  /// This method stops the background location service and closes the location stream.
  Future<void> stopBackgroundLocationService() async {
    await _backgroundLocationRepository.stopLocationService();
    await _locationController.close();
  }
}
