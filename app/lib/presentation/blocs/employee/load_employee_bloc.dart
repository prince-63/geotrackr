import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/use_cases/load_employee.dart';

/// Bloc class for managing employee loading states and events.
class LoadEmployeeBloc extends Cubit<LoadEmployeeState> {
  final LoadEmployee loadEmployee;

  /// Constructor for [LoadEmployeeBloc].
  /// It initializes the class with the given [LoadEmployee] use case.
  LoadEmployeeBloc({required this.loadEmployee}) : super(LoadEmployeeInitial());

  /// Loads the employee details.
  /// Emits different states based on the result of the load operation.
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

/// Abstract class representing the different states of employee loading.
abstract class LoadEmployeeState {}

/// Initial state of employee loading.
class LoadEmployeeInitial extends LoadEmployeeState {}

/// State when employee loading is in progress.
class LoadEmployeeLoading extends LoadEmployeeState {}

/// State when employee loading is successful.
class LoadEmployeeLoaded extends LoadEmployeeState {
  final Employee employee;

  /// Constructor for [LoadEmployeeLoaded].
  /// It initializes the class with the loaded [Employee] object.
  LoadEmployeeLoaded(this.employee);
}

/// State when there is an error during employee loading.
class LoadEmployeeError extends LoadEmployeeState {
  final String message;

  /// Constructor for [LoadEmployeeError].
  /// It initializes the class with the given error message.
  LoadEmployeeError(this.message);
}
