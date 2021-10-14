import 'package:randomusers/storage/entity/UserSM.dart';

abstract class NavigationEvent {}

class AuthNavigationEvent extends NavigationEvent {}

class UserListNavigationEvent extends NavigationEvent {}

class UserDetailsNavigationEvent extends NavigationEvent {
  final UserSM user;

  UserDetailsNavigationEvent(this.user);
}
