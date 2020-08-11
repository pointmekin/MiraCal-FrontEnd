import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/authentication/SigninPage.dart';
import 'package:flutter_app/services/Auth.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  //static bool isDarkMode = false;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",

        ),
        backgroundColor: Colors.transparent,
        elevation: 0,


      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Authentication", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height:10),
            Card(
              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade50: Colors.grey.withOpacity(0.3),

              child:Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            print('Profile pic Clicked');
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [

                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                //GoogleSignin.isSignedIn && GoogleSignin.user != null ? GoogleSignin.user.photoUrl : "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                                                AuthService.theUser == null || AuthService.theUser.photoUrl == null
                                                    ? "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                                                    : AuthService.theUser.photoUrl,
                                              ),

                                            ),
                                          ),



                                        ],
                                      ),
                                    ),

                                  ]
                              ),


                            ],
                          ),
                        ),
                        SizedBox(width:10),
                        /*
                            GoogleSignin.isSignedIn && GoogleSignin.user != null
                                ? Expanded(
                                    child: Text(GoogleSignin.user.displayName != null ? GoogleSignin.user.displayName: "", style: TextStyle(fontSize: 18),),
                                  )
                                : Text("Anonymous")

                             */
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AuthService.theUser == null
                                ? Text("not signed in")
                                : Text(AuthService.theUser.email, style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height:5),

                            AuthService.theUser == null
                                ? InkWell(
                                    onTap: () async{
                                      try {
                                        await _auth.signOut();


                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => SigninPage()),
                                        );
                                      } catch(e) {
                                        print(e.toString());                                }

                                    },
                                    child: Text("Sign in"),
                                  )
                                : InkWell(
                                    onTap: () async{
                                      try {
                                        await _auth.signOut();


                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => SigninPage()),
                                        );
                                      } catch(e) {
                                        print(e.toString());                                }

                                    },
                                    child: Text("Sign out"),
                                  ),
                          ],
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height:20),

// This is the old google signin
/*
                      GoogleSignin.isSignedIn ? OutlineButton(
                        onPressed: (){
                          GoogleSignin.googleSignout();
                          setState(() {
                            GoogleSignin.isSignedIn = false;
                          });


                        },
                        child: Text("Logout"),
                        ) : OutlineButton(
                        onPressed: (){
                          GoogleSignin.handleSignIn();
                          setState(() {
                            GoogleSignin.isSignedIn = true;
                          });



                        },
                        child: Text("Signin with google"),
                      ),
*/
// IDToken button
                  /*
                      OutlineButton(
                        onPressed: () async{
                          GoogleSignin.user != null ? GoogleSignin.user.getIdToken().then((idToken){
                            print(idToken.toString());
                          }) : null;

                          print("UID: " + AuthService.theUser.uid);
                          var idToken = await AuthService.theUser.getIdToken();
                          print("IDToken: " + idToken.toString());

                        },
                        child: Text("IDToken"),
                      ),

                     */

                ],
              ),
            ),
            SizedBox(height:30),

            Text("Theme", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height:10),
            Card(
              color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade50: Colors.grey.withOpacity(0.3),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Use Dark Mode"),
                          Switch(
                            value: Theme.of(context).brightness == Brightness.dark,
                            onChanged: (value) {

                              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                                  //systemNavigationBarColor: Theme.of(context).brightness == Brightness.dark ? Colors.transparent : Colors.black, // navigation bar color
                                  //systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.dark : Brightness.light
                                //statusBarColor: Colors.pink, // status bar color
                              ));

                              DynamicTheme.of(context).setBrightness(
                                  Theme.of(context).brightness == Brightness.light
                                      ? Brightness.dark
                                      : Brightness.light
                              );
                            },
                            activeTrackColor: Palette.miraCalPink.withOpacity(0.5),
                            activeColor: Palette.miraCalPink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
