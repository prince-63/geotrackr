part of 'check_in_bloc.dart';

@immutable
abstract class CheckInEvent {}

class CheckInButtonPressed extends CheckInEvent {
  final String longitude;
  final String latitude;

  CheckInButtonPressed({required this.longitude, required this.latitude});
}

