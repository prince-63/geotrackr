import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/repositories/location_repository.dart';

class GetLocation {
  final LocationRepository repository;

  GetLocation(this.repository);

  Future<Location> call() async {
    return await repository.getLocation();
  }
}
