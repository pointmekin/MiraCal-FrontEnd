import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/pages/SplashScreen2.dart';
import 'package:flutter_app/services/Auth.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'HomeBasePage.dart';
import 'Wrapper.dart';
import 'package:path_provider/path_provider.dart';


class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  /////////////////////
  // JSON STUFF
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  ///////////////////

  final AuthService _auth = AuthService();
  //final user = Provider.of<User>(context);

  void update() async {


      try{

        print("not null");
        String dateTimeNow = DateTime.now().toString();
        String email = AuthService.theUser.email.toString();
        String date = dateTimeNow.substring(3,5) + "-" + dateTimeNow.substring(0, 2) + "-" + dateTimeNow.substring(6,10);

        //String weightDateKey = "weight" + DateTime.now().toString().substring(0,10);

        String calEatenDateKey = "calEaten" + DateTime.now().toString().substring(0,10);

        String foodEatenDateKey = "foodEaten" + DateTime.now().toString().substring(0,10);

        String calWorkoutDateKey = "calWorkout" + DateTime.now().toString().substring(0,10);

        String workoutListDateKey = "workoutList" + DateTime.now().toString().substring(0,10);

        if (fileContent['weight'] != null &&
            fileContent[calEatenDateKey] != null &&
            fileContent[foodEatenDateKey] != null &&
            fileContent[calWorkoutDateKey] != null &&
            fileContent[workoutListDateKey] != null
        ) {

          try {
            await http.post(
              'https://us-central1-miracalapp-e1718.cloudfunctions.net/app/post/miracal-calendar/$email/$date',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'weight' : fileContent['weight'],
                'calEaten': fileContent[calEatenDateKey],
                'foodEatenList' : fileContent[foodEatenDateKey],
                'calWorkout': fileContent[calWorkoutDateKey],
                'workoutList': fileContent[workoutListDateKey]
              }),
            );

          } catch(e) {
            print(e.toString().toUpperCase());
          }

        }

      } catch(e) {
        print(e.toString());
      }
  }



  @override
  void initState() {
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    }).then((value) => (){setState(() {

      if (fileContent != null ) {

      }

    });});
    super.initState();
    //update();
    Future.delayed(const Duration(milliseconds: 700), () {

// Un comment this in version 3 when we finally decided to start signing in

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      );


    });

    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 400,
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 40,),
          Container(child: Center(child: Text("MiraCal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.red)))),
          SizedBox(height: 10,),
          /*
          Image(
            image: AssetImage('lib/assets/MiraCal_logo.png'),
          )

           */

        ],
      ),
    );
  }
}

