import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/remote_check_out.dart';

class RemoteCheckOutBloc extends Cubit<RemoteCheckOutState> {
  final RemoteCheckOut remoteCheckOut;

  RemoteCheckOutBloc({required this.remoteCheckOut})
      : super(RemoteCheckOutInitial());

  Future<void> checkOut() async {
    emit(RemoteCheckOutLoading());
    try {
      final double distance = await remoteCheckOut.call();
      if (distance == 0) {
        emit(RemoteCheckOutSuccess('Remote check-out success'));
      } else {
        emit(RemoteCheckOutFailure('Error: Remote check-out failed'));
      }
    } catch (e) {
      emit(RemoteCheckOutError(e.toString()));
    }
  }
}

abstract class RemoteCheckOutState {}

class RemoteCheckOutInitial extends RemoteCheckOutState {}

class RemoteCheckOutLoading extends RemoteCheckOutState {}

class RemoteCheckOutSuccess extends RemoteCheckOutState {
  final String message;

  RemoteCheckOutSuccess(this.message);
}

class RemoteCheckOutFailure extends RemoteCheckOutState {
  final String message;

  RemoteCheckOutFailure(this.message);
}

class RemoteCheckOutError extends RemoteCheckOutState {
  final String message;

  RemoteCheckOutError(this.message);
}
