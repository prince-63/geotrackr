part of 'background_location_bloc.dart';

abstract class BackgroundLocationState extends Equatable {
  const BackgroundLocationState();

  @override
  List<Object> get props => [];
}

class BackgroundLocationInitial extends BackgroundLocationState {}

class BackgroundLocationLoading extends BackgroundLocationState {}

class BackgroundLocationServiceStarted extends BackgroundLocationState {}

class BackgroundLocationServiceStopped extends BackgroundLocationState {}

class BackgroundLocationUpdated extends BackgroundLocationState {
  final Location location;

  const BackgroundLocationUpdated(this.location);

  @override
  List<Object> get props => [location];
}

class BackgroundLocationError extends BackgroundLocationState {
  final String message;

  const BackgroundLocationError(this.message);

  @override
  List<Object> get props => [message];
}
