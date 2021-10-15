import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomusers/navigator/NavigationBloc.dart';
import 'package:randomusers/navigator/NavigationEvent.dart';
import 'package:randomusers/user/list/UserListEvent.dart';
import 'package:randomusers/user/list/UserListRepository.dart';
import 'package:randomusers/user/list/UserListState.dart';
import 'package:randomusers/storage/entity/UserSM.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final NavigationBloc navigation;
  final UserListRepository repository;
  List<UserSM> _usersList = [];

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

      if (_usersList.isEmpty) {
        _usersList = await repository.loadUsersList();
        yield state.copy(
          isLoading: false,
          users: _usersList,
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

    else if (event is SearchQueryChanged) {
      print("Search query: ${event.query}");
      List<UserSM> results = [];
      var query = event.query?.toLowerCase();
      if (query == null) {
        yield state.copy(users: _usersList);
      }
      else {
        for (var user in _usersList) {
          var name = "${user.firstName} ${user.lastName}".toLowerCase();

          if (name.contains(query)) {
            results.add(user);
          }
        }

        print("Search results count ${results.length}");
        yield state.copy(users: results);
      }
    }

    else if (event is RefreshEvent )
      {
        _usersList.clear();
        _usersList = await repository.loadUsersList();
        yield state.copy(
          isLoading: false,
          users: _usersList,
        );
      }
  }
}
