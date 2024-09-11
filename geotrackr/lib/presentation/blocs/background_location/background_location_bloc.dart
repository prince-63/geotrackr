import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/data/services/background_location_service.dart';
import 'package:geotrackr/domain/entities/location.dart';
import 'package:geotrackr/domain/use_cases/start_background_location_service.dart';
import 'package:geotrackr/domain/use_cases/stop_background_location_service.dart';

part 'background_location_event.dart';
part 'background_location_state.dart';

class BackgroundLocationBloc
    extends Bloc<BackgroundLocationEvent, BackgroundLocationState> {
  final BackgroundLocationService backgroundLocationService;
  final StartBackgroundLocationService startBackgroundLocationService;
  final StopBackgroundLocationService stopBackgroundLocationService;
  StreamSubscription<Location>? _locationSubscription;

  BackgroundLocationBloc(
      {required this.startBackgroundLocationService,
      required this.stopBackgroundLocationService,
      required this.backgroundLocationService})
      : super(BackgroundLocationInitial()) {
    on<StartBackgroundLocationServiceEvent>((event, emit) async {
      emit(BackgroundLocationLoading());
      try {
        await startBackgroundLocationService();
        _locationSubscription =
            backgroundLocationService.locationStream.listen((location) {
          add(LocationUpdated(location));
        });
        emit(BackgroundLocationServiceStarted());
      } catch (e) {
        emit(BackgroundLocationError(e.toString()));
      }
    });

    on<StopBackgroundLocationServiceEvent>((event, emit) async {
      emit(BackgroundLocationLoading());
      try {
        await stopBackgroundLocationService();
        await _locationSubscription?.cancel();
        emit(BackgroundLocationServiceStopped());
      } catch (e) {
        emit(BackgroundLocationError(e.toString()));
      }
    });

    on<LocationUpdated>((event, emit) {
      emit(BackgroundLocationUpdated(event.location));
    });
  }

  Stream<Location> get locationStream =>
      backgroundLocationService.locationStream;
}