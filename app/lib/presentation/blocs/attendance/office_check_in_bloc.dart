import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/office_check_in.dart';

/// Bloc class for managing office check-in states and events.
class OfficeCheckInBloc extends Cubit<OfficeCheckInState> {
  final OfficeCheckIn officeCheckIn;

  /// Constructor for [OfficeCheckInBloc].
  /// It initializes the class with the given [OfficeCheckIn] use case.
  OfficeCheckInBloc({required this.officeCheckIn})
      : super(OfficeCheckInInitial());

  /// Initiates the office check-in process.
  /// Emits different states based on the result of the check-in operation.
  Future<void> checkIn() async {
    emit(OfficeCheckInLoading());
    try {
      final String message = await officeCheckIn.call();
      emit(OfficeCheckInSuccess(message));
    } catch (e) {
      emit(OfficeCheckInError(e.toString()));
    }
  }
}

/// Abstract class representing the different states of office check-in.
abstract class OfficeCheckInState {}

/// Initial state of office check-in.
class OfficeCheckInInitial extends OfficeCheckInState {}

/// State when office check-in is in progress.
class OfficeCheckInLoading extends OfficeCheckInState {}

/// State when office check-in is successful.
class OfficeCheckInSuccess extends OfficeCheckInState {
  final String message;

  /// Constructor for [OfficeCheckInSuccess].
  /// It initializes the class with the given success message.
  OfficeCheckInSuccess(this.message);
}

/// State when there is an error during office check-in.
class OfficeCheckInError extends OfficeCheckInState {
  final String message;

  /// Constructor for [OfficeCheckInError].
  /// It initializes the class with the given error message.
  OfficeCheckInError(this.message);
}