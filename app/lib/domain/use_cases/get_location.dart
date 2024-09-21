import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/repositories/location_repository.dart';

/// This class handles the retrieval of the current location.
class GetLocation {
  final LocationRepository repository;

  /// Constructor for [GetLocation].
  /// It initializes the class with the given [LocationRepository].
  GetLocation(this.repository);

  /// Retrieves the current location.
  /// Returns a [Location] object representing the current location.
  Future<Location> call() async {
    return await repository.getLocation();
  }
}