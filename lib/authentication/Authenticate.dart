import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/SigninPage.dart';
import 'package:flutter_app/authentication/SignupPage.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;


  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SigninPage(toggleView: toggleView) : SignupPage(toggleView: toggleView);
  }
}
