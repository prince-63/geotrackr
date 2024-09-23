part of 'biometric_bloc.dart';

@immutable
abstract class BiometricState {}

/// Initial state of biometric authentication.
class BiometricInitial extends BiometricState {}

/// State when the result of the biometric check is available.
class BiometricCheckResult extends BiometricState {
  final bool canCheckBiometrics;

  /// Constructor for [BiometricCheckResult].
  /// It initializes the class with the result of the biometric check.
  BiometricCheckResult(this.canCheckBiometrics);
}

/// State when the user is successfully authenticated using biometrics.
class BiometricAuthenticated extends BiometricState {}

/// State when the user fails to authenticate using biometrics.
class BiometricUnauthenticated extends BiometricState {}

/// State when there is an error during biometric authentication.
class BiometricError extends BiometricState {
  final String message;

  /// Constructor for [BiometricError].
  /// It initializes the class with the given error message.
  BiometricError(this.message);
}