

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignin {

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseUser user;
  static GoogleSignIn googleSignIn = new GoogleSignIn();

  static bool isSignedIn = false;

  static Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await auth.signInWithCredential(credential));

    user = result.user;

    isSignedIn = true;
    //print("signed in? " + isSignedIn.toString());



  }

  static Future<void> googleSignout() async {
    await auth.signOut().then((onValue){
      googleSignIn.signOut();

      isSignedIn = false;
    });
  }

}


