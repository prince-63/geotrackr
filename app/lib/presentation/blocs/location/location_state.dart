part of 'location_bloc.dart';

/// Abstract class representing the different states of location.
abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

/// Initial state of location.
class LocationInitial extends LocationState {}

/// State when location is being loaded.
class LocationLoading extends LocationState {}

/// State when location is successfully loaded.
class LocationLoaded extends LocationState {
  final Location location; // The loaded location.

  /// Constructor for [LocationLoaded].
  /// It initializes the class with the loaded [Location] object.
  const LocationLoaded(this.location);

  @override
  List<Object> get props => [location];
}

/// State when there is an error during location loading.
class LocationError extends LocationState {
  final String message; // The error message.

  /// Constructor for [LocationError].
  /// It initializes the class with the given error message.
  const LocationError(this.message);

  @override
  List<Object> get props => [message];
}
