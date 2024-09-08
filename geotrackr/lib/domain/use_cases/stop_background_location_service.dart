import 'package:geotrackr/domain/repositories/background_location_repository.dart';

class StopBackgroundLocationService {
  final BackgroundLocationRepository repository;

  StopBackgroundLocationService(this.repository);

  Future<void> call() async {
    return await repository.stopLocationService();
  }
}
