import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/use_cases/check_login_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_status_event.dart';
part 'login_status_state.dart';

/// Bloc class for managing login status states and events.
/// This class handles the login status of the employee.
class LoginStatusBloc extends Bloc<LoginStatusEvent, LoginStatusState> {
  final CheckLoginStatus checkLoginStatus;

  /// Constructor for [LoginStatusBloc].
  /// It initializes the class with the given [checkLoginStatus].
  LoginStatusBloc({required this.checkLoginStatus})
      : super(LoginStatusInitial()) {
    on<CheckLoginStatusEvent>(_check);
  }

  /// Handles the CheckLoginStatusEvent to check if the employee is already logged in.
  Future<void> _check(
      CheckLoginStatusEvent event, Emitter<LoginStatusState> emit) async {
    try {
      emit(LoginStatusLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        final Employee employee = await checkLoginStatus.call();
        emit(LoginStatusLoaded(employee));
      } else {
        emit(LoginStatusInitial());
      }
    } catch (e) {
      emit(LoginStatusError(e.toString()));
    }
  }
}
