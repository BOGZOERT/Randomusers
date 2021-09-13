import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomusers/storage/entity/UserSM.dart';
import 'package:randomusers/user/list/UserListBloc.dart';
import 'package:randomusers/user/list/UserListEvent.dart';
import 'package:randomusers/user/list/UserListState.dart';

class UsersDetails extends StatelessWidget {
  Widget _spacing(BuildContext context) {
    final responsive = MediaQuery.of(context).size.height;
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new SizedBox(
            height: responsive * 0.01,
            width: 500.0,
          ),
        )
      ],
    );
  }

  final UserSM userDetails;

  UsersDetails(this.userDetails) : super();

  @override
  Widget build(BuildContext context) {
    // final double responsive = MediaQuery
    //     .of(context)
    //     .size
    //     .height;

    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) => FutureBuilder(
        future: onLoaded(userListBloc(context)),
        builder: (context, _) => Card(
          child: InkWell(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  foregroundImage: NetworkImage(
                      userDetails.pictureLarge ?? "Error loading image"),
                  backgroundColor: Color(0xff363030),
                ),
                Text(
                  "${userDetails.firstName} ${userDetails.lastName}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(userDetails.email ?? "No email"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UserListBloc userListBloc(BuildContext context) => context.read();

  Future<void> onLoaded(UserListBloc bloc) async {
    bloc.add(InitializedUserListEvent());
  }
}
