abstract class BiometricRepository {
  Future<bool> authenticate();
  Future<bool> canCheckBiometrics();
}
