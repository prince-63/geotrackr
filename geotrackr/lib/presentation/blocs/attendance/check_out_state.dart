part of 'check_out_bloc.dart';

@immutable
abstract class CheckOutState {}

class CheckOutInitial extends CheckOutState {}

class CheckOutLoading extends CheckOutState {}

class CheckOutSuccess extends CheckOutState {
  final String message;

  CheckOutSuccess(this.message);
}

class CheckOutFailure extends CheckOutState {
  final String message;

  CheckOutFailure(this.message);
}

class CheckOutError extends CheckOutState {
  final String message;

  CheckOutError(this.message);
}