import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:geotrackr/domain/use_cases/load_attendances.dart';

/// Bloc class for managing attendance states and events.
class AttendanceBloc extends Cubit<AttendanceState> {
  final LoadAttendances loadAttendances;

  /// Constructor for [AttendanceBloc].
  /// It initializes the class with the given [LoadAttendances] use case.
  AttendanceBloc({required this.loadAttendances}) : super(AttendanceInitial());

  /// Loads the attendance records.
  /// Emits different states based on the result of the load operation.
  Future<void> load() async {
    try {
      emit(AttendanceLoading());
      final attendances = await loadAttendances();
      emit(AttendanceLoaded(attendances));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }
}

/// Abstract class representing the different states of attendance.
abstract class AttendanceState {}

/// Initial state of attendance.
class AttendanceInitial extends AttendanceState {}

/// State when attendance is being loaded.
class AttendanceLoading extends AttendanceState {}

/// State when attendance is successfully loaded.
class AttendanceLoaded extends AttendanceState {
  final List<Attendance> attendances;

  /// Constructor for [AttendanceLoaded].
  /// It initializes the class with the given list of [Attendance] objects.
  AttendanceLoaded(this.attendances);
}

/// State when there is an error loading attendance.
class AttendanceError extends AttendanceState {
  final String message;

  /// Constructor for [AttendanceError].
  /// It initializes the class with the given error message.
  AttendanceError(this.message);
}