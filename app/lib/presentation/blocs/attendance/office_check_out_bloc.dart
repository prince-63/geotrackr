import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/office_check_out.dart';

class OfficeCheckOutBloc extends Cubit<OfficeCheckOutState> {
  final OfficeCheckOut officeCheckOut;

  OfficeCheckOutBloc({required this.officeCheckOut})
      : super(OfficeCheckOutInitial());

  Future<void> checkOut() async {
    emit(OfficeCheckOutLoading());
    try {
      final String message = await officeCheckOut.call();
      emit(OfficeCheckOutSuccess(message));
    } catch (e) {
      emit(OfficeCheckOutError(e.toString()));
    }
  }
}

abstract class OfficeCheckOutState {}

class OfficeCheckOutInitial extends OfficeCheckOutState {}

class OfficeCheckOutLoading extends OfficeCheckOutState {}

class OfficeCheckOutSuccess extends OfficeCheckOutState {
  final String message;

  OfficeCheckOutSuccess(this.message);
}

class OfficeCheckOutError extends OfficeCheckOutState {
  final String message;

  OfficeCheckOutError(this.message);
}
