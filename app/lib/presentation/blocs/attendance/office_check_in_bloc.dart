import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/office_check_in.dart';

class OfficeCheckInBloc extends Cubit<OfficeCheckInState> {
  final OfficeCheckIn officeCheckIn;

  OfficeCheckInBloc({required this.officeCheckIn})
      : super(OfficeCheckInInitial());

  Future<void> checkIn() async {
    emit(OfficeCheckInLoading());
    try {
      final double distance = await officeCheckIn.call();
      if (distance == 0) {
        emit(OfficeCheckInFailure('Check in success'));
      } else if (distance == -1) {
        emit(OfficeCheckInFailure('Error: Check in failed'));
      } else {
        emit(OfficeCheckInFailure(
            'Distance to office is greater than ${200} meters: $distance meters.'));
      }
    } catch (e) {
      emit(OfficeCheckInError(e.toString()));
    }
  }
}

abstract class OfficeCheckInState {}

class OfficeCheckInInitial extends OfficeCheckInState {}

class OfficeCheckInLoading extends OfficeCheckInState {}

class OfficeCheckInSuccess extends OfficeCheckInState {
  final String message;

  OfficeCheckInSuccess(this.message);
}

class OfficeCheckInFailure extends OfficeCheckInState {
  final String message;

  OfficeCheckInFailure(this.message);
}

class OfficeCheckInError extends OfficeCheckInState {
  final String message;

  OfficeCheckInError(this.message);
}
