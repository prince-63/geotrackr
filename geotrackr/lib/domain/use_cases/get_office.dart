import '../entities/office.dart';
import '../repositories/office_repository.dart';

class GetOffice {
  final OfficeRepository repository;

  GetOffice(this.repository);

  Future<Office> call(String id) async {
    return await repository.getOffice(id);
  }
}
