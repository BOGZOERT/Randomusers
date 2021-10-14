import 'package:flutter_bloc/flutter_bloc.dart';

import 'NavigationEvent.dart';
import 'NavigationState.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(AuthNavigationState());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is AuthNavigationEvent) {
      yield AuthNavigationState();
    } else if (event is UserListNavigationEvent) {
      yield UserListNavigationState();
    } else if (event is UserDetailsNavigationEvent) {
      yield UserDetailsNavigationState(event.user);
    }
  }
}
