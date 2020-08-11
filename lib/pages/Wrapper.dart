import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/authentication/Authenticate.dart';
import 'package:flutter_app/authentication/SigninPage.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/pages/HomeBasePage.dart';
import 'package:flutter_app/pages/SplashScreen2.dart';
import 'package:flutter_app/services/Auth.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  /////////////////

  final AuthService _auth = AuthService();


  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      //createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);

  }

  void update(String date) async {



    final user = Provider.of<User>(context, listen:false);

    //final user = AuthService.theUser;

    try{

      print("not null lorr");
      String dateTimeNow = DateTime.now().toString();

      String email;
      email = user.email;
      print(email);
      print(dateTimeNow);

      print(date);

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

          print('https://us-central1-miracalapp-e1718.cloudfunctions.net/app/post/miracal-calendar/$email/$date/');

          final http.Response response = await http.post(
            'https://us-central1-miracalapp-e1718.cloudfunctions.net/app/post/miracal-calendar/$email/$date/',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{

              "$date": {
                'weight' : double.parse(fileContent['weight'].toString()),
                //ex: "weight2020-07-26" : 67

                'calEaten': fileContent[calEatenDateKey] == null ? "" : double.parse(fileContent[calEatenDateKey].toString()),
                //ex: "calEaten2020-07-26" : 1635

                'foodEaten' :  fileContent[foodEatenDateKey] == null ? "" : fileContent[foodEatenDateKey].toString(),
                //ex: "foodEaten2020-07-26" : [[Pad thai with shrimp and egg x 1.0, 545],[Pad thai with shrimp and egg x 1.0, 545]]

                'calWorkout':  fileContent[calWorkoutDateKey] == null ? "" : double.parse(fileContent[calWorkoutDateKey].toString()),
                //ex: "calWorkout2020-07-26" : 184

                'workoutList': fileContent[workoutListDateKey] == null ? "" : fileContent[workoutListDateKey].toString(),
                //ex: "workoutList2020-07-26" : [[Weight Lifting: vigorous 1.0 min, 7]]
              }

            }),
          );

          if(response.body.isNotEmpty) {
            // if update succeeds
            print(json.decode(response.body).toString());
            print("UPDATED");

            Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());

            fileContent['lastUpdated'] = DateTime.now().toString();
            jsonFileContent['lastUpdated'] = fileContent['lastUpdated'];
            fileContent['lastUsed'] = DateTime.now().toString();
            jsonFileContent['lastUsed'] = fileContent['lastUsed'];

            jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this saves the json

          }

          //print(email);
          //print(double.parse(fileContent['weight'].toString()));
          //print(double.parse(fileContent[calEatenDateKey].toString()));
          //print(fileContent[foodEatenDateKey]);
          //print(double.parse(fileContent[calWorkoutDateKey].toString()));
          //print(fileContent[workoutListDateKey]);
          print('https://us-central1-miracalapp-e1718.cloudfunctions.net/app/post/miracal-calendar/$email/$date/');

        } catch(e) {
          print("Error  1 is " + e.toString());
        }
      }
    } catch(e) {
      print("Error  2 is " + e.toString());
    }
  }


  void initState() {
    // TODO: implement initState
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
    super.initState();



  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (fileContent == null) {
      return SplashScreen2();
    } else {

      if (user == null ) {

      } else {

        // if the app doesn't have lastUpdated and lastUsed yet, write to file
        // if time now - last updated is more than 24 hours: update
        // then change last updated and last used time

        if (fileContent != null) {

          if (fileContent['lastUpdated'] == null) {writeToFile("lastUpdated", DateTime.now().toString());}
          if (fileContent['lastUsed'] == null) {writeToFile("lastUsed", DateTime.now().toString());}

          if (fileContent['lastUpdated'] != null && fileContent['lastUsed'] != null){

            int oldYear =  int.parse(fileContent['lastUpdated'].substring(0,4));
            int oldMonth =  int.parse(fileContent['lastUpdated'].substring(5,7));
            int oldDay =  int.parse(fileContent['lastUpdated'].substring(8,10));
            int oldHour =  int.parse(fileContent['lastUpdated'].substring(11,13));

            int newYear = int.parse(DateTime.now().toString().substring(0,4));
            int newMonth = int.parse(DateTime.now().toString().substring(5,7));
            int newDay = int.parse(DateTime.now().toString().substring(8,10));
            int newHour = int.parse(DateTime.now().toString().substring(11,13));

            if (newYear >= oldYear){
              print("DID NOT UPDATE: NOT YET 24 HOURS");
              if(newMonth >= oldMonth) {
                print("DID NOT UPDATE: NOT YET 24 HOURS");
                if (newDay >= oldDay) {
                  print("DID NOT UPDATE: NOT YET 24 HOURS");
                  if (newHour > oldHour) {



                    String lastUsedDate = fileContent['lastUsed'].substring(5,7) +  "-" + fileContent['lastUsed'].substring(8,10)+ "-"  + fileContent['lastUsed'].substring(0,4);
                    String lastUpdatedDate = fileContent['lastUpdated'].substring(5,7) +  "-" + fileContent['lastUpdated'].substring(8,10)+ "-"  + fileContent['lastUpdated'].substring(0,4);

                    if (lastUpdatedDate == lastUsedDate){
                      update(lastUpdatedDate);

                    } else {
                      // update the last-used date
                      update(lastUsedDate);
                      // update the last-updated date
                      update(lastUpdatedDate);
                    }







                  }
                }
              }
            }
          }
        }

        //update();




      }


      return HomeBasePage();
    }




    //return fileContent == null ? SplashScreen2() : HomeBasePage();
  }
}



