import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "Privacy Policy",
              //style: TextStyle(color: Colors.black),
            ),

            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
              "The MiraCal team will be recording the user information entered into this mobile application by the user offline (on the device), and online (on a private,secure database) for the purpose of backing up user information.",
              style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
