import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Question1.dart';
//import 'package:flutter_app/pages/StartPageForNewUser.dart';
import 'HomeBasePage.dart';
import '../authentication/SigninPage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class SplashScreen2 extends StatefulWidget {
  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {

  /////////////////////
  // JSON STUFF
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  ///////////////////



  @override
  void initState() {
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
    super.initState();




    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 100,),
          Text("MiraCal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.red)),
          SizedBox(height: 50,),
          Container(
            height: 50,
            width: 200,

            child: InkWell(
              onTap: () {
                print('go to FoodSearch Page');
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Question1()),
                );

              },
              splashColor: Colors.white12,
              focusColor: Colors.white30,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xFFE39090

                        ),
                    boxShadow: [
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
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(20, 10, 25, 10),

                  child: Center(
                    child: Text(
                      "Start",
                      style: TextStyle(
                          color: Colors.grey.shade200,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),

          ),
          SizedBox(height: 100,),
          Image(
            image: AssetImage('lib/assets/MiraCal_logo.png'),
          )

        ],
      ),
    );
  }
}

