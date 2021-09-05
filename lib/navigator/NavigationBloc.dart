import 'package:flutter_bloc/flutter_bloc.dart';

import 'NavigationEvent.dart';
import 'NavigationState.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {

  NavigationBloc() : super(NavigationState.authorization);

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.authorization:
        yield NavigationState.authorization;
        break;
      case NavigationEvent.usersList:
        yield NavigationState.usersList;
        break;
      case NavigationEvent.userDetails:
        yield NavigationState.userDetails;
        break;
    }
  }
}
