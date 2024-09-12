import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/check_out.dart';

part 'check_out_event.dart';
part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  final CheckOut checkOut;

  CheckOutBloc({required this.checkOut}) : super(CheckOutInitial()) {
    on<CheckOutButtonPressed>(_checkOut);
  }

  Future<void> _checkOut(
      CheckOutButtonPressed event, Emitter<CheckOutState> emit) async {
    emit(CheckOutLoading());
    try {
      final bool isCheckOut = await checkOut(event.longitude, event.latitude);
      if (isCheckOut) {
        emit(CheckOutSuccess('Check out success'));
      } else {
        emit(CheckOutFailure('Check out failed'));
      }
    } catch (e) {
      emit(CheckOutError(e.toString()));
    }
  }
}
