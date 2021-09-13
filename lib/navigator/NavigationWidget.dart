import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomusers/auth/AuthWidget.dart';
import 'package:randomusers/navigator/NavigationBloc.dart';
import 'package:randomusers/navigator/NavigationState.dart';
import 'package:randomusers/user/details/UserDetails.dart';
import 'package:randomusers/user/list/UserList.dart';


class NavigationWidget extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (_, state) {
        switch (state) {
          case NavigationState.authorization:
            return AuthWidget();
          case NavigationState.usersList:
            return UserList();
          case NavigationState.userDetails:
            return UsersDetails();

        }
      },
    );
  }
}
