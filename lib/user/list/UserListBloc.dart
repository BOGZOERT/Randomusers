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
    if (event is InitializedUserListEvent) {
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
    } else if (event is LogoutUserListEvent) {
      yield state.copy(isLoading: true);
      repository.logout();
      yield _initialState;
      navigation.add(AuthNavigationEvent());
    } else if (event is DetailsRequestedUserListEvent) {
      navigation.add(UserDetailsNavigationEvent(event.user));
    }
  }
}
