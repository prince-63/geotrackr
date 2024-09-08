part of 'background_location_bloc.dart';

abstract class BackgroundLocationEvent extends Equatable {
  const BackgroundLocationEvent();

  @override
  List<Object> get props => [];
}

class StartBackgroundLocationServiceEvent extends BackgroundLocationEvent {}

class StopBackgroundLocationServiceEvent extends BackgroundLocationEvent {}

class LocationUpdated extends BackgroundLocationEvent {
  final Location location;

  const LocationUpdated(this.location);

  @override
  List<Object> get props => [location];
}
