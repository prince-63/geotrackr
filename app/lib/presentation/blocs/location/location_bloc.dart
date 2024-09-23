import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/use_cases/get_location.dart';

part 'location_event.dart';
part 'location_state.dart';

/// Bloc class for managing location states and events.
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocation getLocation;

  /// Constructor for [LocationBloc].
  /// It initializes the class with the given [GetLocation] use case.
  LocationBloc(this.getLocation) : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationLoading());
      try {
        final location = await getLocation();
        emit(LocationLoaded(location));
      } catch (e) {
        emit(LocationError(e.toString()));
      }
    });
  }
}
