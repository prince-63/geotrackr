import 'package:geotrackr/domain/repositories/biometric_repository.dart';
import 'package:local_auth/local_auth.dart';

class BiometricRepositoryImpl implements BiometricRepository {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  Future<bool> authenticate() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason:
            'Scan your fingerprint or use your biometric credentials to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      isAuthenticated = false;
    }
    return isAuthenticated;
  }

  @override
  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }
}
