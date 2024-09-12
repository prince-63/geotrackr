import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:geotrackr/domain/use_cases/load_attendances.dart';

class AttendanceBloc extends Cubit<AttendanceState> {
  final LoadAttendances loadAttendances;

  AttendanceBloc({required this.loadAttendances}) : super(AttendanceInitial());

  Future<void> load() async {
    try {
      emit(AttendanceLoading());
      final List<Attendance> attendances = await loadAttendances();
      emit(AttendanceLoaded(attendances));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }
}

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<Attendance> attendances;

  AttendanceLoaded(this.attendances);
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError(this.message);
}
