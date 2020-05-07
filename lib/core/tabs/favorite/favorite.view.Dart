import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/core/tabs/components/appbar.comp.dart';
import 'package:movie_helper/core/tabs/favorite/components/profile.comp.dart';
import 'package:movie_helper/services/authentification.service.dart';
import 'package:movie_helper/services/http.service.dart';

class FavoriteView extends StatefulWidget {
  final BaseAuth auth;
  final String userId;
  final VoidCallback logoutCallback;

  FavoriteView({this.auth, this.userId, this.logoutCallback});
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  HttpService httpService = new HttpService();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          title: "Favoris",
          topLeftColor: Colors.pink,
          bottomRightColor: Colors.pinkAccent,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                FutureBuilder(
                  future: widget.auth.getCurrentUser(),
                  builder: (context, AsyncSnapshot<FirebaseUser> snap) {
                    if (snap.hasData) {
                      FirebaseUser user = snap.data;
                      return Profile(user: user);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                OutlineButton(
                  child: Text("SIGN OUT"),
                  onPressed: signOut,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void signOut() async {
    widget.auth.signOut();
    widget.logoutCallback();
  }
}
