import 'package:randomusers/storage/entity/UserSM.dart';

class UserListState {
  UserListState({
    required this.username,
    required this.isLoading,
    required this.users,
  });

  final String? username;
  final bool isLoading;
  final List<UserSM> users;

  UserListState copy({
    String? username,
    bool? isLoading,
    List<UserSM>? users,
  }) {
    return UserListState(
      username: username ?? this.username,
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
    );
  }
}
