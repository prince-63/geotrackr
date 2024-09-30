import 'package:geotrackr/domain/repositories/auth_repository.dart';

class ForgotPassword {
  final AuthRepository authRepository;

  ForgotPassword(this.authRepository);

  Future<String> call(String email) async {
    return await authRepository.forgotPassword(email);
  }
}
