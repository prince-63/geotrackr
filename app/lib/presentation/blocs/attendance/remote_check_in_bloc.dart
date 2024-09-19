import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/remote_check_in.dart';

class RemoteCheckInBloc extends Cubit<RemoteCheckInState> {
  final RemoteCheckIn remoteCheckIn;

  RemoteCheckInBloc({required this.remoteCheckIn})
      : super(RemoteCheckInInitial());

  Future<void> checkIn() async {
    emit(RemoteCheckInLoading());
    try {
      final String message = await remoteCheckIn.call();
      emit(RemoteCheckInSuccess(message));
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

class RemoteCheckInError extends RemoteCheckInState {
  final String message;

  RemoteCheckInError(this.message);
}
