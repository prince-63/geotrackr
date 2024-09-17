import 'package:geotrackr/domain/entities/location.dart';

abstract class LocationRepository {
  Future<Location> getLocation();
  Future<double> getDistanceBetween(Location location1, Location location2);
}
