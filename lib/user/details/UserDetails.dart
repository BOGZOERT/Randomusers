import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
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

    return BlocBuilder<UserListBloc, UserListState>(

      builder: (context, state) => FutureBuilder(

        future: onLoaded(userListBloc(context)),

        builder: (context, _) => Scaffold(
            appBar: AppBar(

              actions:<Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  tooltip: 'Back',
                  onPressed: () => userListBloc(context).add(LogoutUserListEvent()),   /** передать значение для возврата (logout) **/
                ),
              ]
            ),
          body: Column( children: <Widget>[
               Container(
                padding:EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                height: 300.0,

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: PhotoView(
                    imageProvider: NetworkImage(userDetails.pictureLarge ?? "Error loading image"),
                    maxScale: PhotoViewComputedScale.covered * 2.0,
                    minScale: PhotoViewComputedScale.contained * 0.9,
                    initialScale: PhotoViewComputedScale.covered,

                  ),
                ),
              ),

            Text(
              "${userDetails.firstName} ${userDetails.lastName}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userDetails.email  ?? "No email",
              textAlign: TextAlign.center,),

            Text(
              userDetails.phone ?? "No phone",
              textAlign: TextAlign.center,),
          ]
          )
                ),
          )
        );
  }



  UserListBloc userListBloc(BuildContext context) => context.read();
  Future<void> onLoaded(UserListBloc bloc) async {
    bloc.add(InitializedUserListEvent());
  }
}
