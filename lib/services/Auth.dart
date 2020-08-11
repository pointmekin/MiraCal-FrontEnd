import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/SignupPage.dart';
import 'package:flutter_app/models/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseUser theUser;

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user )=> _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }


  // sign in anonymously
  Future signInAnon() async{
    try {

      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      theUser = user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print("Error " + e.toString());
      return null;
    }
  }



  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // this is the user model that was custom made
      theUser = user;

      if (user.isEmailVerified) {
        return _userFromFirebaseUser(user);
      } else {

        Fluttertoast.showToast(
            msg: "Please verify your email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.withOpacity(0.5),
            textColor: Colors.white,
            fontSize: 16.0
        );
        return null;
      }



    } catch(e) {
      print ("Error: " + e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // this is the user model that was custom made
      theUser = user;
      // wait for Jow
      /*
      String identifier = user.uid;
      String method = 'get';
      http.Response response = await http.get(
          'https://us-central1-miracalapp-e1718.cloudfunctions.net/app/$method/auth/personal-data/$identifier');
      */

      try {
        await user.sendEmailVerification();
        //return _userFromFirebaseUser(user);

        Fluttertoast.showToast(
            msg: "Please verify your email.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.grey.withOpacity(0.5),
            textColor: Colors.white,
            fontSize: 16.0
        );

        await _auth.signOut();

      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);

      }



    } catch(e) {
      print ("Error: " + e.toString());
      return (e.message.toString());
    }
  }

  // signin with google
  //FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = new GoogleSignIn();

  bool isSignedIn = false;

  Future handleGoogleSignIn() async {

    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

      AuthResult result = (await _auth.signInWithCredential(credential));

      theUser = result.user;
      return  theUser;


    } catch(e) {
      print("Error: " + e.toString());
    }



    //isSignedIn = true;
    //print("signed in? " + isSignedIn.toString());



  }

  Future googleSignout() async {
    await _auth.signOut().then((onValue){
      googleSignIn.signOut();

      //isSignedIn = false;
    });
  }


  // signout
  Future signOut() async {
    try {
      theUser = null;

      return await _auth.signOut();
    } catch(e) {
      print("Error: " + e.toString());
      return null;
    }
  }
}