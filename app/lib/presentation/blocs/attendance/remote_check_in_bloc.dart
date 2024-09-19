import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/remote_check_in.dart';

class RemoteCheckInBloc extends Cubit<RemoteCheckInState> {
  final RemoteCheckIn remoteCheckIn;

  RemoteCheckInBloc({required this.remoteCheckIn})
      : super(RemoteCheckInInitial());

  Future<void> checkIn() async {
    emit(RemoteCheckInLoading());
    try {
      final double distance = await remoteCheckIn.call();
      if (distance == 0) {
        emit(RemoteCheckInSuccess('Remote check-in success'));
      } else {
        emit(RemoteCheckInFailure('Error: Remote check-in failed'));
      }
    } catch (e) {
      emit(RemoteCheckInError(e.toString()));
    }
  }
}

abstract class RemoteCheckInState {}

class RemoteCheckInInitial extends RemoteCheckInState {}

class RemoteCheckInLoading extends RemoteCheckInState {}

class RemoteCheckInSuccess extends RemoteCheckInState {
  final String message;

  RemoteCheckInSuccess(this.message);
}

class RemoteCheckInFailure extends RemoteCheckInState {
  final String message;

  RemoteCheckInFailure(this.message);
}

class RemoteCheckInError extends RemoteCheckInState {
  final String message;

  RemoteCheckInError(this.message);
}
