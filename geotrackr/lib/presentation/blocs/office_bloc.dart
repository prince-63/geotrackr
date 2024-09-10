import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/office.dart';

class OfficeBloc extends Cubit<OfficeState> {
  OfficeBloc(super.initialState);

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
