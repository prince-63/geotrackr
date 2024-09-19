part of 'biometric_bloc.dart';

@immutable
abstract class BiometricEvent {}

class CheckBiometricsEvent extends BiometricEvent {}

class AuthenticateEvent extends BiometricEvent {}