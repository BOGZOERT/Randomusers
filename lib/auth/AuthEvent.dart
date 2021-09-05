import 'package:flutter/cupertino.dart';

@immutable
abstract class AuthEvent {}

class InitializeAuthEvent extends AuthEvent {}

class UsernameChangedAuthEvent extends AuthEvent {
  final String username;

  UsernameChangedAuthEvent(this.username);
}

class SubmitPressedAuthEvent extends AuthEvent {}
