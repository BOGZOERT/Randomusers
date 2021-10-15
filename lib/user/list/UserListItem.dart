import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:randomusers/storage/entity/UserSM.dart';
import 'package:randomusers/user/list/UserListBloc.dart';

import 'UserListEvent.dart';

class UserListItem extends StatelessWidget {
  final UserSM user;
  final UserListBloc bloc;

  UserListItem({
    required this.user,
    required this.bloc,
  }) : super();

  @override
  Widget build(
    BuildContext context,
  ) {
    return InkWell(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            foregroundImage:
                NetworkImage(user.pictureLarge ?? "Error loading image"),
            backgroundColor: Color(0xff363030),
          ),
          Text(
            "${user.firstName} ${user.lastName}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(user.email ?? "No email"),
        ],
      ),
      onTap: () {
        bloc.add(DetailsRequestedUserListEvent(user));
      },
    );
  }
}
