import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomusers/api/RandomUserApi.dart';
import 'package:randomusers/auth/AuthBloc.dart';
import 'package:randomusers/navigator/NavigationBloc.dart';
import 'package:randomusers/navigator/NavigationWidget.dart';
import 'package:randomusers/storage/settings.dart';
import 'package:randomusers/user/list/UserListBloc.dart';
import 'package:randomusers/user/list/UserListRepository.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(navigation: context.read()),
          ),
          BlocProvider<UserListBloc>(
            create: (context) => UserListBloc(
              repository: UserListRepositoryImpl(
                settings: SettingsImpl(),
                api: RandomUserApiImpl(),
              ),
              navigation: context.read(),
            ),
          )
        ],
        child: NavigationWidget(),
      ),
    );
  }
}
