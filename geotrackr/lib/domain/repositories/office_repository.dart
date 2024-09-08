import '../entities/office.dart';

abstract class OfficeRepository {
  Future<Office> getOffice(String id);
}
