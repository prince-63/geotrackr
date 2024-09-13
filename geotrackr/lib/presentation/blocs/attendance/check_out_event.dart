part of 'check_out_bloc.dart';

@immutable
abstract class CheckOutEvent {}

class CheckOutButtonPressed extends CheckOutEvent {
  final String longitude;
  final String latitude;

  CheckOutButtonPressed({required this.longitude, required this.latitude});
}