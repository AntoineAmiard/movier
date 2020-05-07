import 'package:flutter/material.dart';
import 'package:movie_helper/services/authentification.service.dart';

class GoogleButton extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;
  GoogleButton({this.auth, this.loginCallback});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onPressed() async {
    String userId = await auth.signInWithGoogle();
    if (userId.length > 0 && userId != null) {
      loginCallback();
    } else {}
  }
}
