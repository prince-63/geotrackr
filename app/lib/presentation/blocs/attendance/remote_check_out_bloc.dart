import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/remote_check_out.dart';

/// Bloc class for managing remote check-out states and events.
class RemoteCheckOutBloc extends Cubit<RemoteCheckOutState> {
  final RemoteCheckOut remoteCheckOut;

  /// Constructor for [RemoteCheckOutBloc].
  /// It initializes the class with the given [RemoteCheckOut] use case.
  RemoteCheckOutBloc({required this.remoteCheckOut})
      : super(RemoteCheckOutInitial());

  /// Initiates the remote check-out process.
  /// Emits different states based on the result of the check-out operation.
  Future<void> checkOut() async {
    emit(RemoteCheckOutLoading());
    try {
      final String message = await remoteCheckOut.call();
      emit(RemoteCheckOutSuccess(message));
    } catch (e) {
      emit(RemoteCheckOutError(e.toString()));
    }
  }
}

/// Abstract class representing the different states of remote check-out.
abstract class RemoteCheckOutState {}

/// Initial state of remote check-out.
class RemoteCheckOutInitial extends RemoteCheckOutState {}

/// State when remote check-out is in progress.
class RemoteCheckOutLoading extends RemoteCheckOutState {}

/// State when remote check-out is successful.
class RemoteCheckOutSuccess extends RemoteCheckOutState {
  final String message;

  /// Constructor for [RemoteCheckOutSuccess].
  /// It initializes the class with the given success message.
  RemoteCheckOutSuccess(this.message);
}

/// State when there is an error during remote check-out.
class RemoteCheckOutError extends RemoteCheckOutState {
  final String message;

  /// Constructor for [RemoteCheckOutError].
  /// It initializes the class with the given error message.
  RemoteCheckOutError(this.message);
}