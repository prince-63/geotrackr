import 'package:geotrackr/domain/repositories/biometric_repository.dart';

/// This class handles biometric authentication operations.
class AuthenticateBiometric {
  final BiometricRepository repository;

  /// Constructor for [AuthenticateBiometric].
  /// It initializes the class with the given [BiometricRepository].
  AuthenticateBiometric(this.repository);

  /// Authenticates the user using biometric credentials.
  /// Returns `true` if the authentication is successful, otherwise `false`.
  Future<bool> authenticate() async {
    return await repository.authenticate();
  }

  /// Checks if the device can check for biometric authentication.
  /// Returns `true` if the device supports biometric authentication, otherwise `false`.
  Future<bool> canCheckBiometrics() async {
    return await repository.canCheckBiometrics();
  }
}