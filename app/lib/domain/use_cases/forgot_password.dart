import 'package:geotrackr/domain/repositories/auth_repository.dart';

class ForgotPassword {
  final AuthRepository authRepository;

  ForgotPassword(this.authRepository);

  Future<void> call(String email) async {
    return await authRepository.forgotPassword(email);
  }
}
