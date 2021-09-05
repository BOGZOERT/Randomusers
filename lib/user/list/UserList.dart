import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomusers/user/list/UserListBloc.dart';
import 'package:randomusers/user/list/UserListEvent.dart';
import 'package:randomusers/user/list/UserListItem.dart';
import 'package:randomusers/user/list/UserListState.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) => FutureBuilder(
        future: onLoaded(userListBloc(context)),
        builder: (context, _) => Scaffold(
          appBar: AppBar(
            title: Text(state.username ?? "ERROR"),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => userListBloc(context).add(UserListEvent.logout),
              child: Icon(Icons.logout),
            ),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return UserListItem(user: state.users[index]);
            },
            itemCount: state.users.length,
          ),
        ),
      ),
    );
  }

  UserListBloc userListBloc(BuildContext context) => context.read();

  Future<void> onLoaded(UserListBloc bloc) async {
    bloc.add(UserListEvent.initialized);
  }
}
