import 'package:geotrackr/domain/repositories/auth_repository.dart';

/// This class handles the setting of a new password.
/// It takes the password reset code as a parameter.
class SetNewPassword {
  final AuthRepository authRepository;

  SetNewPassword(this.authRepository);

  /// Updates the employee password.
  Future<void> call(String code) async {
    return await authRepository.setNewPassword(code);
  }
}
