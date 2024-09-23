import '../entities/office.dart';
import '../repositories/office_repository.dart';

/// This class handles the loading of office details.
class LoadOffice {
  final OfficeRepository _repository;

  /// Constructor for [LoadOffice].
  /// It initializes the class with the given [OfficeRepository].
  LoadOffice(this._repository);

  /// Loads the office details.
  /// Returns an [Office] object if the details are successfully loaded.
  Future<Office> call() async {
    return await _repository.loadOffice();
  }
}