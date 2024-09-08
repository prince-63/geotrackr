import 'package:geotrackr/domain/entities/location.dart';

abstract class LocationRepository {
  Future<Location> getLocation();
  Future<void> startLocationService();
  Future<void> stopLocationService();
  Stream<Location> getLocationStream();
}
