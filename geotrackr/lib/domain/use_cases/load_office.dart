import '../entities/office.dart';
import '../repositories/office_repository.dart';

class LoadOffice {
  final OfficeRepository _repository;

  LoadOffice(this._repository);

  Future<Office> call() async {
    return await _repository.loadOffice();
  }
}
