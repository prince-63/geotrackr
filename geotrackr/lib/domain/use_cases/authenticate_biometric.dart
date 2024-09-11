import 'package:geotrackr/domain/repositories/biometric_repository.dart';

class AuthenticateBiometric {
  final BiometricRepository repository;

  AuthenticateBiometric(this.repository);

  Future<bool> authenticate() async {
    return await repository.authenticate();
  }

  Future<bool> canCheckBiometrics() async {
    return await repository.canCheckBiometrics();
  }
}
