part of 'check_in_bloc.dart';

@immutable
abstract class CheckInState {}

class CheckInInitial extends CheckInState {}

class CheckInLoading extends CheckInState {}

class CheckInSuccess extends CheckInState {
  final String message;

  CheckInSuccess(this.message);
}

class CheckInFailure extends CheckInState {
  final String message;

  CheckInFailure(this.message);
}

class CheckInError extends CheckInState {
  final String message;

  CheckInError(this.message);
}
