import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/remote_check_in.dart';

/// Bloc class for managing remote check-in states and events.
class RemoteCheckInBloc extends Cubit<RemoteCheckInState> {
  final RemoteCheckIn remoteCheckIn;

  /// Constructor for [RemoteCheckInBloc].
  /// It initializes the class with the given [RemoteCheckIn] use case.
  RemoteCheckInBloc({required this.remoteCheckIn})
      : super(RemoteCheckInInitial());

  /// Initiates the remote check-in process.
  /// Emits different states based on the result of the check-in operation.
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

/// Abstract class representing the different states of remote check-in.
abstract class RemoteCheckInState {}

/// Initial state of remote check-in.
class RemoteCheckInInitial extends RemoteCheckInState {}

/// State when remote check-in is in progress.
class RemoteCheckInLoading extends RemoteCheckInState {}

/// State when remote check-in is successful.
class RemoteCheckInSuccess extends RemoteCheckInState {
  final String message;

  /// Constructor for [RemoteCheckInSuccess].
  /// It initializes the class with the given success message.
  RemoteCheckInSuccess(this.message);
}

/// State when there is an error during remote check-in.
class RemoteCheckInError extends RemoteCheckInState {
  final String message;

  /// Constructor for [RemoteCheckInError].
  /// It initializes the class with the given error message.
  RemoteCheckInError(this.message);
}
