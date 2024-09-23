part of 'biometric_bloc.dart';

/// Abstract class representing the different events for biometric authentication.
@immutable
abstract class BiometricEvent {}

/// Event to check if the device can perform biometric authentication.
class CheckBiometricsEvent extends BiometricEvent {}

/// Event to authenticate the user using biometric credentials.
class AuthenticateEvent extends BiometricEvent {}