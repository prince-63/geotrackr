import 'package:geotrackr/domain/repositories/auth_repository.dart';

/// This class handles the verification of the forgot password code.
/// It returns a boolean value indicating whether the code is valid.
class VerifyForgotPassword {
  final AuthRepository authRepository;

  VerifyForgotPassword(this.authRepository);

  /// Verifies the password reset code.
  Future<bool> call(String code) async {
    return await authRepository.verifyForgotPasswordCode(code);
  }
}
