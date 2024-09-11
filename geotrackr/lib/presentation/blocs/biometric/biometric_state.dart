part of 'biometric_bloc.dart';

@immutable
abstract class BiometricState {}

class BiometricInitial extends BiometricState {}

class BiometricCheckResult extends BiometricState {
  final bool canCheckBiometrics;

  BiometricCheckResult(this.canCheckBiometrics);
}

class BiometricAuthenticated extends BiometricState {}

class BiometricUnauthenticated extends BiometricState {}

class BiometricError extends BiometricState {
  final String message;

  BiometricError(this.message);
}
