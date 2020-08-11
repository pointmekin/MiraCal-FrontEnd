import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/SigninPage.dart';
import 'package:flutter_app/components/Loading.dart';
import 'package:flutter_app/pages/Question1.dart';
import 'package:flutter_app/pages/privacyPolicy.dart';
import 'package:flutter_app/services/Auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class SignupPage extends StatefulWidget {

  final Function toggleView;
  SignupPage({this.toggleView});


  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  // text field state
  String email = '';
  String password = '';
  static String error = '';
  bool loading = false;
  bool _acceptedPrivacyPolicy = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String userName = "Point";
  double cardWidth;
  var whiteThemeColor = Colors.grey.shade200;
  var darkThemeColor = Colors.black;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
  }

  void setError(String signUpError) {
    error = signUpError;
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      //backgroundColor: whiteThemeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "Sign up",
              //style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text("Sign in"),
                onPressed: (){
                  //widget.toggleView();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SigninPage()),
                  );

                },
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,


          child: Form(
            key: _formKey,
            child: Column(

              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 0,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text("Email")),
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
                    child: Text("Password")),
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
                          //validator: (value) => value.isEmpty ? 'Enter an email' : null,
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




                Center(
                  child: InkWell(
                    onTap: () async {

                      if (_acceptedPrivacyPolicy){

                        print('Sign up pressed');

                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          print(email);
                          print(password);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if (result is String) {
                            setState(() {
                              loading = false;
                              error = result ;//'please supply a valid email';
                            });

                          }
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
                          color: _acceptedPrivacyPolicy
                              ? Theme.of(context).brightness == Brightness.light ? Palette.miraCalPink: Palette.miraCalPink.withOpacity(0.8)
                              : Colors.grey.shade500.withOpacity(0.6),

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
                                    "Sign up",
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
                Center(
                  child: Text(
                    error, style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(
                      child: Text("Already have an account? Sign in here.", style: TextStyle(color: Color(0xFFE39090), fontWeight: FontWeight.bold),),
                      onTap: (){
                        print("Go to Sign in page");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SigninPage()),
                        );

                      },
                    ),
                    SizedBox(width: 5,),
                    Container(height: 10, width: 2, color: Colors.grey,),
                    SizedBox(width: 5,),
                    InkWell(
                      child: Text("Skip", style: TextStyle(color: Colors.grey),),
                      onTap: (){
                        print("Skip signup");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Question1()),
                        );

                      },
                    ),
                  ],
                ),
                SizedBox(height:10),

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
