import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/get_office.dart';
import 'package:geotrackr/domain/entities/office.dart';

class OfficeBloc extends Cubit<OfficeState> {
  final GetOffice getOffice;

  OfficeBloc(this.getOffice) : super(OfficeInitial());

  Future<void> fetchOffice(String id) async {
    try {
      emit(OfficeLoading());
      final office = await getOffice(id);
      emit(OfficeLoaded(office));
    } catch (e) {
      emit(OfficeError('Failed to load office'));
    }
  }
}

abstract class OfficeState {}

class OfficeInitial extends OfficeState {}

class OfficeLoading extends OfficeState {}

class OfficeLoaded extends OfficeState {
  final Office office;

  OfficeLoaded(this.office);
}

class OfficeError extends OfficeState {
  final String message;

  OfficeError(this.message);
}
