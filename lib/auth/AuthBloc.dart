import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomusers/auth/AuthEvent.dart';
import 'package:randomusers/auth/AuthRepository.dart';
import 'package:randomusers/auth/AuthState.dart';
import 'package:randomusers/auth/AuthValidator.dart';
import 'package:randomusers/navigator/NavigationBloc.dart';
import 'package:randomusers/navigator/NavigationEvent.dart';
import 'package:randomusers/storage/settings.dart';
import 'package:randomusers/storage/storage.dart';





class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final NavigationBloc navigation;
  final AuthValidator _validator = SimpleAuthValidator();
  final AuthRepository _repository = AuthRepository.create(
    storage: HiveStorageImpl(),
    settings: SettingsImpl(),
  );

  AuthBloc({required this.navigation}) : super(_initialState);

  static AuthState _initialState = AuthState(
    allowEditing: false,
    isLoading: false,
    result: null,
    username: null,
  );

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is InitializeAuthEvent) {
      var username = await _repository.username();
      if (await _repository.isAuthorized() && username != null) {
        await _repository.login(username);
        yield _initialState;
        navigation.add(NavigationEvent.usersList);
      } else {
        yield state.copy(allowEditing: true);
      }
    } else if (event is UsernameChangedAuthEvent) {
      yield state.copy(username: event.username);
    } else if (event is SubmitPressedAuthEvent) {
      var username = state.username;
      if (username != null && _validator.validate(username)) {
        yield state.copy(
          isLoading: true,
          allowEditing: false,
        );

        await _repository.login(username);
        yield _initialState;

        navigation.add(NavigationEvent.usersList);
      }
    }
  }
}
