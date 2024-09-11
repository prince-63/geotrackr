import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/use_cases/load_employee.dart';

class LoadEmployeeBloc extends Cubit<LoadEmployeeState> {
  final LoadEmployee loadEmployee;

  LoadEmployeeBloc({required this.loadEmployee}) : super(LoadEmployeeInitial());

  Future<void> load() async {
    try {
      emit(LoadEmployeeLoading());
      final Employee employee = await loadEmployee();
      emit(LoadEmployeeLoaded(employee));
    } catch (e) {
      emit(LoadEmployeeError(e.toString()));
    }
  }
}

abstract class LoadEmployeeState {}

class LoadEmployeeInitial extends LoadEmployeeState {}

class LoadEmployeeLoading extends LoadEmployeeState {}

class LoadEmployeeLoaded extends LoadEmployeeState {
  final Employee employee;

  LoadEmployeeLoaded(this.employee);
}

class LoadEmployeeError extends LoadEmployeeState {
  final String message;

  LoadEmployeeError(this.message);
}
