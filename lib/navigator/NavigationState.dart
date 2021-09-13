import 'package:randomusers/storage/entity/UserSM.dart';

abstract class NavigationState {}

class AuthNavigationState extends NavigationState {}

class UserListNavigationState extends NavigationState {}

class UserDetailsNavigationState extends NavigationState {
  final UserSM user;

  UserDetailsNavigationState(this.user);
}
