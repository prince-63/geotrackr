part of 'location_bloc.dart';

/// Abstract class representing the different events for location.
abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

/// Event to get the current location.
class GetLocationEvent extends LocationEvent {}
