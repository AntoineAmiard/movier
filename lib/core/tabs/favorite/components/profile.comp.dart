import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final FirebaseUser user;
  Profile({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(user.photoUrl),
          ),
          Text("  " + user.displayName.split(" ")[0]),
          Expanded(child: Container()),
          Icon(
            Icons.settings,
            size: 35,
          ),
        ],
      ),
    );
  }
}
