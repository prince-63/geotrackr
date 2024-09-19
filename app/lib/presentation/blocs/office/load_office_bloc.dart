import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/office.dart';
import 'package:geotrackr/domain/use_cases/load_office.dart';

class LoadOfficeBloc extends Cubit<LoadOfficeState> {
  final LoadOffice loadOffice;

  LoadOfficeBloc({required this.loadOffice}) : super(LoadOfficeInitial());

  Future<void> load() async {
    try {
      emit(LoadOfficeLoading());
      final Office office = await loadOffice();
      emit(LoadOfficeLoaded(office));
    } catch (e) {
      emit(LoadOfficeError(e.toString()));
    }
  }
}

abstract class LoadOfficeState {}

class LoadOfficeInitial extends LoadOfficeState {}

class LoadOfficeLoading extends LoadOfficeState {}

class LoadOfficeLoaded extends LoadOfficeState {
  final Office office;

  LoadOfficeLoaded(this.office);
}

class LoadOfficeError extends LoadOfficeState {
  final String message;

  LoadOfficeError(this.message);
}
