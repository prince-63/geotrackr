import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/attendance.dart';
import 'package:geotrackr/domain/use_cases/load_today_attendance.dart';

class LoadTodayAttendanceBloc extends Cubit<LoadTodayAttendanceState> {
  final LoadTodayAttendance loadTodayAttendance;

  LoadTodayAttendanceBloc({required this.loadTodayAttendance})
      : super(LoadTodayAttendanceInitial());

  Future<void> load() async {
    try {
      emit(LoadTodayAttendanceLoading());
      final attendance = await loadTodayAttendance();
      emit(LoadTodayAttendanceLoaded(attendance));
    } catch (e) {
      emit(LoadTodayAttendanceError(e.toString()));
    }
  }
}

abstract class LoadTodayAttendanceState {}

class LoadTodayAttendanceInitial extends LoadTodayAttendanceState {}

class LoadTodayAttendanceLoading extends LoadTodayAttendanceState {}

class LoadTodayAttendanceLoaded extends LoadTodayAttendanceState {
  final Attendance attendance;

  LoadTodayAttendanceLoaded(this.attendance);
}

class LoadTodayAttendanceError extends LoadTodayAttendanceState {
  final String message;

  LoadTodayAttendanceError(this.message);
}
