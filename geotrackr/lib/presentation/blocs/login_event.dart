import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {}

class CheckLoginEvent extends LoginEvent {}

class LoginRequestedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginRequestedEvent(this.email, this.password);
}