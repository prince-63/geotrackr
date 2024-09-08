import 'dart:async';
import 'dart:io';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/repositories/background_location_repository.dart';
import 'package:path_provider/path_provider.dart';

class BackgroundLocationRepositoryImpl extends BackgroundLocationRepository {
  final _locationController = StreamController<Location>();

  /// This method starts the background location service.
  @override
  Future<void> startLocationService() async {
    await BackgroundLocator.initialize();
    final dir = await getApplicationDocumentsDirectory();
    // Create a file to store the location data
    final file = File('${dir.path}/location_log.txt');
    if (!file.existsSync()) {
      file.createSync();
    }

    // Start the background location service
    BackgroundLocator.registerLocationUpdate(
      _locationCallback,
      initCallback: _initCallback,
      initDataCallback: {'countInit': 1},
      disposeCallback: _disposeCallback,
      iosSettings: const IOSSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        distanceFilter: 0,
      ),
      autoStop: false,
    );
  }

  @override
  Future<void> stopLocationService() async {
    await BackgroundLocator.unRegisterLocationUpdate();
  }

  @override
  Stream<Location> getLocationStream() {
    return _locationController.stream;
  }

  static void _locationCallback(LocationDto locationDto) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/location_log.txt');
    final location = Location(
      latitude: locationDto.latitude,
      longitude: locationDto.longitude,
    );
    file.writeAsStringSync(
      '${location.latitude}, ${location.longitude}\n',
      mode: FileMode.append,
    );
  }

  static void _initCallback(Map<dynamic, dynamic> params) {
    print('BackgroundLocator initialized');
  }

  static void _disposeCallback() {
    print('BackgroundLocator disposed');
  }
}
