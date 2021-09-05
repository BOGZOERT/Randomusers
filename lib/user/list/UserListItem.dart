import 'package:flutter/cupertino.dart';
import 'package:randomusers/storage/entity/UserSM.dart';

class UserListItem extends StatelessWidget {
  final UserSM user;

  UserListItem({required this.user}) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "${user.firstName} ${user.lastName}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(user.email ?? "No email")
        ],
      ),
    );
  }
}
