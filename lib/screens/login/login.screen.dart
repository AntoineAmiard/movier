import 'package:flutter/material.dart';
import 'package:movie_helper/screens/login/components/Google-button.comp.dart';
import 'package:movie_helper/services/authentification.service.dart';

class LoginScreen extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;

  LoginScreen({this.auth, this.loginCallback});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              GoogleButton(
                auth: widget.auth,
                loginCallback: widget.loginCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
