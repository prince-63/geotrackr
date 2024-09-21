import '../entities/office.dart';

/// Abstract class representing the office repository.
/// This class defines the method for loading office details.
abstract class OfficeRepository {
  /// Loads the office details.
  /// Returns an [Office] object if the details are successfully loaded.
  Future<Office> loadOffice();
}