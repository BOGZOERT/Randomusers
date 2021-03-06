import 'package:randomusers/storage/entity/UserSM.dart';

abstract class UserListEvent {}

class InitializedUserListEvent extends UserListEvent {}

class LogoutUserListEvent extends UserListEvent {}

class DetailsRequestedUserListEvent extends UserListEvent {
  final UserSM user;

  DetailsRequestedUserListEvent(this.user);
}

class SearchQueryChanged extends UserListEvent {
  final String? query;

  SearchQueryChanged(this.query);
}

class RefreshEvent extends UserListEvent {

}