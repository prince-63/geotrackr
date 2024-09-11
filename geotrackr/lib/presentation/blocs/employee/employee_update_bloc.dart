import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/use_cases/update_employee_details.dart';
import 'package:meta/meta.dart';

part 'employee_update_event.dart';
part 'employee_update_state.dart';

class EmployeeUpdateBloc
    extends Bloc<EmployeeUpdateEvent, EmployeeUpdateState> {
  final UpdateEmployeeDetails _updateEmployeeDetails;

  EmployeeUpdateBloc(this._updateEmployeeDetails)
      : super(EmployeeUpdateInitial()) {
    on<EmployeeUpdate>(_onUpdateEmployee);
  }

  Future<void> _onUpdateEmployee(
      EmployeeUpdate event, Emitter<EmployeeUpdateState> emit) async {
    try {
      emit(EmployeeUpdateLoading());
      final employee = await _updateEmployeeDetails.call(
          event.employeeName, event.employeeEmail, event.employeeContactNumber);
      emit(EmployeeUpdateLoaded(employee));
    } catch (e) {
      emit(EmployeeUpdateError(e.toString()));
    }
  }
}
