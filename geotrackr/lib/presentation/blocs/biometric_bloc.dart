import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/authenticate_biometric.dart';
import 'package:meta/meta.dart';

part 'biometric_event.dart';
part 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final AuthenticateBiometric authenticateBiometric;

 BiometricBloc({required this.authenticateBiometric})
      : super(BiometricInitial()) {
    on<CheckBiometricsEvent>(_onCheckBiometrics);
    on<AuthenticateEvent>(_onAuthenticate);
  }

  Future<void> _onCheckBiometrics(
      CheckBiometricsEvent event, Emitter<BiometricState> emit) async {
    try {
      final canCheckBiometrics =
          await authenticateBiometric.canCheckBiometrics();
      emit(BiometricCheckResult(canCheckBiometrics));
    } catch (e) {
      emit(BiometricError(e.toString()));
    }
  }

  Future<void> _onAuthenticate(
      AuthenticateEvent event, Emitter<BiometricState> emit) async {
    try {
      final authenticated = await authenticateBiometric.authenticate();
      if (authenticated) {
        emit(BiometricAuthenticated());
      } else {
        emit(BiometricUnauthenticated());
      }
    } catch (e) {
      emit(BiometricError(e.toString()));
    }
  }
}
