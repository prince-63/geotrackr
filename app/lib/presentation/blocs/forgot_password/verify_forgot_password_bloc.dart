import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/verify_forgot_password.dart';

/// Bloc class for verifying the forgot password.
/// This class handles the state of verifying the forgot password.
class VerifyForgotPasswordBloc extends Cubit<VerifyForgotPasswordState> {
  final VerifyForgotPassword verifyForgotPassword;

  VerifyForgotPasswordBloc({required this.verifyForgotPassword})
      : super(VerifyForgotPasswordInitial());

  /// Verifies the forgot password code.
  /// Emits [VerifyForgotPasswordLoading] state when the code is being verified.
  void verifyForgotPass(String code) async {
    emit(VerifyForgotPasswordLoading());
    try {
      final bool = await verifyForgotPassword.call(code);
      if (bool) {
        emit(VerifyForgotPasswordSuccess('Verification successful'));
      } else {
        emit(VerifyForgotPasswordFailure(
            'Verification failed Please try again'));
      }
    } catch (e) {
      emit(VerifyForgotPasswordFailure(e.toString()));
    }
  }
}

abstract class VerifyForgotPasswordState {}

class VerifyForgotPasswordInitial extends VerifyForgotPasswordState {}

class VerifyForgotPasswordLoading extends VerifyForgotPasswordState {}

class VerifyForgotPasswordSuccess extends VerifyForgotPasswordState {
  final String message;

  VerifyForgotPasswordSuccess(this.message);
}

class VerifyForgotPasswordFailure extends VerifyForgotPasswordState {
  final String message;

  VerifyForgotPasswordFailure(this.message);
}
