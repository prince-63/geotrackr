import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/office_check_out.dart';

/// Bloc class for managing office check-out states and events.
class OfficeCheckOutBloc extends Cubit<OfficeCheckOutState> {
  final OfficeCheckOut officeCheckOut;

  /// Constructor for [OfficeCheckOutBloc].
  /// It initializes the class with the given [OfficeCheckOut] use case.
  OfficeCheckOutBloc({required this.officeCheckOut})
      : super(OfficeCheckOutInitial());

  /// Initiates the office check-out process.
  /// Emits different states based on the result of the check-out operation.
  Future<void> checkOut() async {
    emit(OfficeCheckOutLoading());
    try {
      final String message = await officeCheckOut.call();
      emit(OfficeCheckOutSuccess(message));
    } catch (e) {
      emit(OfficeCheckOutError(e.toString()));
    }
  }
}

/// Abstract class representing the different states of office check-out.
abstract class OfficeCheckOutState {}

/// Initial state of office check-out.
class OfficeCheckOutInitial extends OfficeCheckOutState {}

/// State when office check-out is in progress.
class OfficeCheckOutLoading extends OfficeCheckOutState {}

/// State when office check-out is successful.
class OfficeCheckOutSuccess extends OfficeCheckOutState {
  final String message;

  /// Constructor for [OfficeCheckOutSuccess].
  /// It initializes the class with the given success message.
  OfficeCheckOutSuccess(this.message);
}

/// State when there is an error during office check-out.
class OfficeCheckOutError extends OfficeCheckOutState {
  final String message;

  /// Constructor for [OfficeCheckOutError].
  /// It initializes the class with the given error message.
  OfficeCheckOutError(this.message);
}