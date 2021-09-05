import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomusers/auth/AuthBloc.dart';
import 'package:randomusers/auth/AuthEvent.dart';

import 'AuthState.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return FutureBuilder(
                future: _onLoaded(authBloc(context)),
                initialData: 0,
                builder: (context, _) => Column(
                  children: [
                    Text(
                      "Login\nState: ${stateToString(state)}",
                    ),
                    Padding(padding: EdgeInsets.only(top: 16)),
                    TextField(
                      onChanged: (value) => onUsernameChanged(
                        username: value,
                        bloc: authBloc(context),
                      ),
                      enabled: state.allowEditing,
                    ),
                    Padding(padding: EdgeInsets.only(top: 16)),
                    TextButton(
                      onPressed: () => onLogin(context),
                      child: Text('Login'),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AuthBloc authBloc(BuildContext context) => context.read();

  Future<void> _onLoaded(AuthBloc bloc) async {
    bloc.add(InitializeAuthEvent());
  }

  String stateToString(AuthState state) {
    if (state.allowEditing) {
      return "edit ${state.username}";
    } else if (state.isLoading) {
      return "loading";
    } else if (state.result == AuthStateResult.success) {
      return "success ${state.username}";
    } else if (state.result == AuthStateResult.failure) {
      return "failure";
    } else {
      return "other";
    }
  }

  void onUsernameChanged({
    required String? username,
    required AuthBloc bloc,
  }) {
    if (username != null) {
      bloc.add(UsernameChangedAuthEvent(username));
    }
  }

  void onLogin(BuildContext context) {
    context.read<AuthBloc>().add(SubmitPressedAuthEvent());
  }
}
