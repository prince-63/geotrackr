import 'package:geotrackr/domain/entities/location.dart';

abstract class BackgroundLocationRepository {
  Future<void> startLocationService();
  Future<void> stopLocationService();
  Stream<Location> getLocationStream();
}
