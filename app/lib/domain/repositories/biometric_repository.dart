/// Abstract class representing the biometric repository.
/// This class defines the methods for handling biometric authentication.
abstract class BiometricRepository {
  /// Authenticates the user using biometric credentials.
  /// Returns `true` if the authentication is successful, otherwise `false`.
  Future<bool> authenticate();

  /// Checks if the device can check for biometric authentication.
  /// Returns `true` if the device supports biometric authentication, otherwise `false`.
  Future<bool> canCheckBiometrics();
}