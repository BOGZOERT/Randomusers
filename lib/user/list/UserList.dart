import 'dart:io';

import 'package:flutter/cupertino.dart';
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
                  centerTitle: true,
                  actions: <Widget>[
                    Center(
                        child: Text(
                          ("${state.username}  "),
                    ))
                  ],
                  title: TextField(
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: " Search...",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        color: Color.fromRGBO(93, 25, 72, 1),
                        onPressed: () {},
                      ),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    onChanged: (value) {
                      onSearchQueryChanged(value, userListBloc(context));
                    },
                  ),
                  leading: GestureDetector(
                    onTap: () =>
                        userListBloc(context).add(LogoutUserListEvent()),
                    child: Icon(Icons.logout),
                  ),
                ),
                body: new RefreshIndicator(
                  onRefresh: () async => onRefresh(userListBloc(context)),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return UserListItem(
                        user: state.users[index],
                        bloc: userListBloc(context),
                      );
                    },
                    itemCount: state.users.length,
                  ),
                ),
              ),
            ));
  }

  UserListBloc userListBloc(BuildContext context) => context.read();

  Future<void> onLoaded(UserListBloc bloc) async {
    bloc.add(InitializedUserListEvent());
  }

  Future<void> onRefresh(UserListBloc bloc) async {
    bloc.add(RefreshEvent());
  }


  void onSearchQueryChanged(String? query, UserListBloc bloc) {
    bloc.add(SearchQueryChanged(query));
  }
}
