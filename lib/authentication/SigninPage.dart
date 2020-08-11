import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/Loading.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/HomeBasePage.dart';
import 'package:flutter_app/pages/Question1.dart';
import 'package:flutter_app/pages/SplashScreen2.dart';
import 'package:flutter_app/pages/privacyPolicy.dart';
import 'package:flutter_app/services/Auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'SignupPage.dart';

class SigninPage extends StatefulWidget {

  final Function toggleView;
  SigninPage({this.toggleView});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  ////// JSON stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  //final AuthService _auth = AuthService();
  ///////////////////////////

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool _acceptedPrivacyPolicy = true;

  final _formKey = GlobalKey<FormState>();

  // authentication states
  final AuthService _auth = AuthService();
  // other states
  double cardWidth;

  // controllers
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();





  @override
  void initState() {
    //TODO: implement initState

    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      //backgroundColor: Palette.whiteThemeBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "Sign in",
              //style: TextStyle(color: Colors.black),

            ),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text("Sign up"),
                onPressed: (){
                  //widget.toggleView();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );


                },
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height-100,


            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  //height: MediaQuery.of(context).size.height-400,
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Text("Email"),
                            ],
                          )),
                      SizedBox(height: 15,),
                      //This is the search box
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            /*
                            BoxShadow(
                              color: Colors.grey.withOpacity(.5),
                              blurRadius: 20.0, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset: Offset(
                                5.0, // Move to right 10  horizontally
                                5.0, // Move to bottom 10 Vertically
                              ),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset: Offset(
                                -5.0, // Move to right 10  horizontally
                                -5.0, // Move to bottom 10 Vertically
                              ),
                            )

                             */
                          ],
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        padding: EdgeInsets.symmetric(horizontal: 15),

                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) => value.isEmpty ? 'Enter an email' : null,
                                onChanged: (value){
                                  setState(() {
                                    email = value;
                                  });
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintText: "example@gmail.com",
                                    border: InputBorder.none),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {

                                },
                                child: Container(/*child: Icon(Icons.search)*/)),
                          ],
                        ),


                      ),
                      SizedBox(height: 15,),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Text("Password"),
                            ],
                          )),
                      SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            /*
                            BoxShadow(
                              color: Colors.grey.withOpacity(.5),
                              blurRadius: 20.0, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset: Offset(
                                5.0, // Move to right 10  horizontally
                                5.0, // Move to bottom 10 Vertically
                              ),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset: Offset(
                                -5.0, // Move to right 10  horizontally
                                -5.0, // Move to bottom 10 Vertically
                              ),
                            )

                             */
                          ],
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        padding: EdgeInsets.symmetric(horizontal: 15),

                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) => value.length < 6 ? 'Enter a password with at least 6 chars' : null,
                                onChanged: (value){
                                  setState(() {
                                    password = value;
                                  });
                                },
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                    hintText: "password",
                                    border: InputBorder.none),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {

                                },
                                child: Container(/*child: Icon(Icons.search)*/)),
                          ],
                        ),


                      ),

                      SizedBox(height: 30,),

                      Center(
                        child: InkWell(
                          onTap: () async {
                            print('Sign in pressed');
                            if (_formKey.currentState.validate()) {

                              await _auth.signOut();

                              setState(() {
                                loading = true;
                              });
                              print(email);
                              print(password);
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Could not sign in with those credentials';
                                });

                              } else {
                                setState(() {
                                  loading = false;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeBasePage()),
                                  );
                                });
                              }



                            }
                            /*
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeBasePage()),
                      );
                       */
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Theme.of(context).brightness == Brightness.light ? Palette.miraCalPink: Palette.miraCalPink.withOpacity(0.8),
                                boxShadow: [
                                  /*
                                  BoxShadow(

                                    color: Colors.grey.withOpacity(.5),
                                    blurRadius: 20.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: Offset(
                                      5.0, // Move to right 10  horizontally
                                      5.0, // Move to bottom 10 Vertically
                                    ),
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 15.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: Offset(
                                      -5.0, // Move to right 10  horizontally
                                      -5.0, // Move to bottom 10 Vertically
                                    ),
                                  )

                                   */
                                ],
                              ),
                              padding: EdgeInsets.fromLTRB(20, 13, 25, 10),
                              height: 50,
                              width: 380,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Text(
                                          "Sign in",
                                          style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14),
                                        ),

                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      InkWell(
                        onTap: () async{
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                            Fluttertoast.showToast(
                                msg: "Password reset email sent.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          } catch(e) {
                            setState(() {
                              error = "Please specify a valid email for password reset";
                            });
                          }

                        },

                        child: Text("Forgot Password?", style: TextStyle(color:Colors.grey),),


                      ),
                      SizedBox(height:10),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(height: 20,),
// this is for anonymous sign in which we will not use
                            /*
                Center(
                  child: FlatButton(
                    color: Colors.grey[300],
                    onPressed: () async {
                      dynamic result = await _auth.signInAnon();
                      if (result == null) {
                        print("error signing in");
                      } else {
                        print("signed in");
                        print(result.uid);
                      }

                    },
                    child: Container(
                      width: 150,
                        height: 30,
                        child: Center(child: Text("Sign in anonymously"))),
                  ),

                ),
                SizedBox(height: 10),

               */



                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          error, style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          /*
                          InkWell(
                            child: Text("Create an account", style: TextStyle(color: Color(0xFFE39090), fontWeight: FontWeight.bold),),
                            onTap: (){
                              print("Go to signup page");
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SignupPage()),
                              );
                            },
                          ),
                          SizedBox(width: 5,),
                          Container(height: 10, width: 2, color: Colors.grey,),
                          SizedBox(width: 5,),
                           */

                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  //height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      InkWell(
                        onTap: (){

                          if (fileContent == null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Question1()),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomeBasePage()),
                            );
                          }


                        },

                        child: Text("Skip", style: TextStyle(color:Colors.grey),),


                      ),
                      SizedBox(height:5),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30),
                        child: Divider(),
                      ),

                      SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20),
                        child: Row(
                          children: [
                            Checkbox(
                              //title: const Text('Animate Slowly'),
                              activeColor: Palette.miraCalPink,
                              value: _acceptedPrivacyPolicy,
                              onChanged: (bool value){
                                setState(() {
                                  _acceptedPrivacyPolicy = !_acceptedPrivacyPolicy;
                                });
                              },

                            ),
                            Text("* I accept the "),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                              },
                              child: Text("Privacy policy.", style: TextStyle(decoration: TextDecoration.underline),),
                            ),
                            Text("."),
                          ],
                        ),
                      ),
// this is for anonymous sign in which we will not use
                      /*
                Center(
                  child: FlatButton(
                    color: Colors.grey[300],
                    onPressed: () async {
                      dynamic result = await _auth.signInAnon();
                      if (result == null) {
                        print("error signing in");
                      } else {
                        print("signed in");
                        print(result.uid);
                      }

                    },
                    child: Container(
                      width: 150,
                        height: 30,
                        child: Center(child: Text("Sign in anonymously"))),
                  ),

                ),
                SizedBox(height: 10),

               */
                      Center(
                        child: Container(

                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                //side: BorderSide(color: Colors.red)
                            ),
                            color: _acceptedPrivacyPolicy 
                                ? Colors.red[400].withOpacity(0.9)
                                : Colors.grey.shade500.withOpacity(0.6),
                            onPressed: ()async {
                              if(_acceptedPrivacyPolicy) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth.handleGoogleSignIn();

                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Could not sign in with those credentials';
                                  });

                                } else {
                                  setState(() {
                                    loading = false;

                                    if (fileContent == null) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => SplashScreen2()),
                                      );

                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomeBasePage()),
                                      );

                                    }



                                  });
                                }
                              }

                            },
                            child: Container(

                                height: 50,
                                width:MediaQuery.of(context).size.width-80,
                                child: Center(
                                    child: Text("Sign in with Google",style: TextStyle(color: Colors.white),),
                                )),
                          ),
                        ),

                      ),
                      SizedBox(height:20),


                    ],
                  ),
                ),





                /*
                Image(
                  image: AssetImage('lib/assets/MiraCal_logo.png'),
                )

                 */
                //This is a button

                // end of button



              ],
            ),
          ),
        ),
      ),
      //bottomNavigationBar: NavBar(),
    );
  }
}
