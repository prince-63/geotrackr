import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/check_in.dart';
import 'package:meta/meta.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final CheckIn checkIn;

  CheckInBloc(this.checkIn) : super(CheckInInitial()) {
    on<CheckInButtonPressed>(_checkIn);
  }

  Future<void> _checkIn(
      CheckInButtonPressed event, Emitter<CheckInState> emit) async {
    emit(CheckInLoading());
    try {
      final bool isCheckIn = await checkIn(event.longitude, event.latitude);
      if (isCheckIn) {
        emit(CheckInSuccess('Check in success'));
      } else {
        emit(CheckInFailure('Check in failed'));
      }
    } catch (e) {
      emit(CheckInError(e.toString()));
    }
  }
}
