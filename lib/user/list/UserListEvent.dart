import 'package:randomusers/storage/entity/UserSM.dart';

abstract class UserListEvent {}

class InitializedUserListEvent extends UserListEvent {}

class LogoutUserListEvent extends UserListEvent {}

class DetailsRequestedUserListEvent extends UserListEvent {
  final UserSM user;

  DetailsRequestedUserListEvent(this.user);
}
