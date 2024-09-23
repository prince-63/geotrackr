import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/employee.dart';
import 'package:geotrackr/domain/use_cases/employee_update_details.dart';
import 'package:meta/meta.dart';

part 'employee_update_event.dart';
part 'employee_update_state.dart';

/// Bloc class for managing employee update states and events.
class EmployeeUpdateBloc
    extends Bloc<EmployeeUpdateEvent, EmployeeUpdateState> {
  final EmployeeUpdateDetails employeeUpdateDetails;

  /// Constructor for [EmployeeUpdateBloc].
  /// It initializes the class with the given [EmployeeUpdateDetails] use case.
  EmployeeUpdateBloc({required this.employeeUpdateDetails})
      : super(EmployeeUpdateInitial()) {
    on<EmployeeUpdate>(_onUpdateEmployee);
  }

  /// Handles the [EmployeeUpdate] event.
  /// Emits different states based on the result of the update operation.
  Future<void> _onUpdateEmployee(
      EmployeeUpdate event, Emitter<EmployeeUpdateState> emit) async {
    try {
      emit(EmployeeUpdateLoading());
      final employee = await employeeUpdateDetails.call(
          event.employeeName, event.employeeEmail, event.employeeContactNumber);
      emit(EmployeeUpdateLoaded(employee));
    } catch (e) {
      emit(EmployeeUpdateError(e.toString()));
    }
  }
}