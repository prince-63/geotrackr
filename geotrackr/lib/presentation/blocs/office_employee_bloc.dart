import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/office_employee.dart';
import 'package:geotrackr/domain/use_cases/login_office_employee.dart';

class OfficeEmployeeBloc extends Cubit<OfficeEmployeeState> {
  final LoginOfficeEmployee loginOfficeEmployee;

  OfficeEmployeeBloc({required this.loginOfficeEmployee})
      : super(OfficeEmployeeInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(OfficeEmployeeLoading());
      final officeEmployee = await loginOfficeEmployee(email, password);
      emit(OfficeEmployeeLoaded(officeEmployee));
    } catch (e) {
      emit(OfficeEmployeeError(e.toString()));
    }
  }
}

abstract class OfficeEmployeeState {}

class OfficeEmployeeInitial extends OfficeEmployeeState {}

class OfficeEmployeeLoading extends OfficeEmployeeState {}

class OfficeEmployeeLoaded extends OfficeEmployeeState {
  final OfficeEmployee officeEmployee;

  OfficeEmployeeLoaded(this.officeEmployee);
}

class OfficeEmployeeError extends OfficeEmployeeState {
  final String message;

  OfficeEmployeeError(this.message);
}
