import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/employee.dart';

class EmployeeBloc extends Cubit<EmployeeState> {
  EmployeeBloc(super.initialState);
}

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final Employee employee;

  EmployeeLoaded(this.employee);
}

class EmployeeError extends EmployeeState {
  final String message;

  EmployeeError(this.message);
}
