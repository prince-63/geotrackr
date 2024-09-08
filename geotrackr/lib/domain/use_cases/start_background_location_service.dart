import 'package:geotrackr/domain/repositories/background_location_repository.dart';

class StartBackgroundLocationService {
  final BackgroundLocationRepository repository;

  StartBackgroundLocationService(this.repository);

  Future<void> call() async {
    return await repository.startLocationService();
  }
}
