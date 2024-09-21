import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/office.dart';
import 'package:geotrackr/domain/use_cases/load_office.dart';

/// Bloc class for managing office loading states and events.
class LoadOfficeBloc extends Cubit<LoadOfficeState> {
  final LoadOffice loadOffice;

  /// Constructor for [LoadOfficeBloc].
  /// It initializes the class with the given [LoadOffice] use case.
  LoadOfficeBloc({required this.loadOffice}) : super(LoadOfficeInitial());

  /// Loads the office details.
  /// Emits different states based on the result of the load operation.
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

/// Abstract class representing the different states of office loading.
abstract class LoadOfficeState {}

/// Initial state of office loading.
class LoadOfficeInitial extends LoadOfficeState {}

/// State when office loading is in progress.
class LoadOfficeLoading extends LoadOfficeState {}

/// State when office loading is successful.
class LoadOfficeLoaded extends LoadOfficeState {
  final Office office;

  /// Constructor for [LoadOfficeLoaded].
  /// It initializes the class with the loaded [Office] object.
  LoadOfficeLoaded(this.office);
}

/// State when there is an error during office loading.
class LoadOfficeError extends LoadOfficeState {
  final String message;

  /// Constructor for [LoadOfficeError].
  /// It initializes the class with the given error message.
  LoadOfficeError(this.message);
}
