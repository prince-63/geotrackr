import 'package:geotrackr/domain/repositories/biometric_repository.dart';
import 'package:local_auth/local_auth.dart';

/// Implementation of the [BiometricRepository] interface.
/// This class handles biometric authentication using the [LocalAuthentication] package.
class BiometricRepositoryImpl implements BiometricRepository {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  /// Authenticates the user using biometric credentials.
  /// Returns `true` if the authentication is successful, otherwise `false`.
  @override
  Future<bool> authenticate() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason:
            'Scan your fingerprint or use your biometric credentials to authenticate', // Reason shown to the user for authentication.
        options: const AuthenticationOptions(
          useErrorDialogs: true, // Whether to show error dialogs.
          stickyAuth: true, // Whether to keep the authentication active.
        ),
      );
    } catch (e) {
      isAuthenticated = false; // Authentication failed.
    }
    return isAuthenticated;
  }

  /// Checks if the device can check for biometric authentication.
  /// Returns `true` if the device supports biometric authentication, otherwise `false`.
  @override
  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      return false; // Cannot check biometrics.
    }
  }
}
