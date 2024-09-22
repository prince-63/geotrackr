import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/set_new_password.dart';

/// Bloc class for setting the new password.
/// This class handles the state of setting the new password.
class SetNewPasswordBloc extends Cubit<SetNewPasswordState> {
  final SetNewPassword setNewPassword;

  SetNewPasswordBloc({required this.setNewPassword})
      : super(SetNewPasswordInitial());

  /// Sets the new password for the user.
  /// Emits [SetNewPasswordLoading] state when the password is being set.
  void setNewPass(String password) async {
    emit(SetNewPasswordLoading());
    try {
      await setNewPassword.call(password);
      emit(SetNewPasswordSuccess());
    } catch (e) {
      emit(SetNewPasswordError(e.toString()));
    }
  }
}

abstract class SetNewPasswordState {}

class SetNewPasswordInitial extends SetNewPasswordState {}

class SetNewPasswordLoading extends SetNewPasswordState {}

class SetNewPasswordSuccess extends SetNewPasswordState {
  final String message;

  SetNewPasswordSuccess(
      {this.message = 'Password has been successfully updated.'});
}

class SetNewPasswordError extends SetNewPasswordState {
  final String message;

  SetNewPasswordError(this.message);
}
