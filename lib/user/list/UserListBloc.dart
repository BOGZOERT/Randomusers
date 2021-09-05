import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomusers/navigator/NavigationBloc.dart';
import 'package:randomusers/navigator/NavigationEvent.dart';
import 'package:randomusers/user/list/UserListEvent.dart';
import 'package:randomusers/user/list/UserListRepository.dart';
import 'package:randomusers/user/list/UserListState.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final NavigationBloc navigation;
  final UserListRepository repository;

  UserListBloc({
    required this.repository,
    required this.navigation,
  }) : super(_initialState);

  static final UserListState _initialState = UserListState(
    username: null,
    isLoading: true,
    users: [],
  );

  @override
  Stream<UserListState> mapEventToState(UserListEvent event) async* {
    switch (event) {
      case UserListEvent.initialized:
        yield state.copy(
          username: await repository.username(),
          isLoading: true,
        );

        if (state.users.isEmpty) {
          yield state.copy(
            isLoading: false,
            users: await repository.loadUsersList(),
          );
        }

        break;
      case UserListEvent.logout:
        yield state.copy(isLoading: true);
        repository.logout();
        yield _initialState;
        navigation.add(NavigationEvent.authorization);
        break;
    }
  }
}