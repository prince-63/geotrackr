import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/forgot_password.dart';

class ForgotPasswordBloc extends Cubit<ForgotPasswordState> {
  final ForgotPassword forgotPassword;

  ForgotPasswordBloc({required this.forgotPassword})
      : super(ForgotPasswordInitial());

  Future<void> forgot(String email) async {
    try {
      emit(ForgotPasswordLoading());
      await forgotPassword.call(email);
      emit(ForgotPasswordSuccess("Password reset link sent to your email"));
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
}

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;

  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  ForgotPasswordError(this.message);
}
