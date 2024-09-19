import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/office_check_out.dart';

class OfficeCheckOutBloc extends Cubit<OfficeCheckOutState> {
  final OfficeCheckOut officeCheckOut;

  OfficeCheckOutBloc({required this.officeCheckOut})
      : super(OfficeCheckOutInitial());

  Future<void> checkOut() async {
    emit(OfficeCheckOutLoading());
    try {
      final double distance = await officeCheckOut.call();
      if (distance == 0) {
        emit(OfficeCheckOutSuccess('Check out success'));
      } else if (distance == -1) {
        emit(OfficeCheckOutFailure('Error: Check out failed'));
      } else {
        emit(OfficeCheckOutFailure(
            'Distance to office is less than ${200} meters: $distance meters.'));
      }
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

class OfficeCheckOutFailure extends OfficeCheckOutState {
  final String message;

  OfficeCheckOutFailure(this.message);
}

class OfficeCheckOutError extends OfficeCheckOutState {
  final String message;

  OfficeCheckOutError(this.message);
}
