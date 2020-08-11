import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/foodCalCard2.dart';
import 'package:flutter_app/components/textLiquidFill.dart';
import 'package:flutter_app/components/workoutCalCard.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/pages/UpdateWeightPage.dart';
import 'package:flutter_app/info/foodData.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/services/Auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'Calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userName = "Point";
  double cardWidth;
  var whiteThemeColor = Colors.grey.shade200;
  var darkThemeColor = Colors.black;
  String weightDisplay = '';
  String intensity;
  //////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  /////////////////

  final AuthService _auth = AuthService();

  fetchUserData() async{
    //String searchQuery = query.toString().toLowerCase();
    http.Response response =
    await http.get('https://us-central1-miracalapp-e1718.cloudfunctions.net/app//get/miracal-calendar/testuser@testuser.com/2020');
    String stringResponse = json.decode(response.body).toString();
    print(stringResponse);



  }

  String getIntensity() {

    if (fileContent['goal'] == "Maintain weight") {
      return ("-");
    } else if (fileContent['weightGoalPlan'] == "1") {
      return ("1 kg in 1 week");
    } else if (fileContent['weightGoalPlan'] == "2") {
      return ("1 kg in 2 weeks");
    } else if (fileContent['weightGoalPlan'] == "3") {
      return ("1 kg in 3 weeks");
    } else if (fileContent['weightGoalPlan'] == "4") {
      return ("1 kg in 4 weeks");
    } else {
      return (" ");
    }
  }


  String showWeightDisplay(String weightDisplay) {

    setState(() {
      weightDisplay = fileContent == null ? ' ' : fileContent['weight'];

    });
    return weightDisplay;
  }

  String remainingWeight(weightDisplay){
    double weightNow = fileContent == null ? 0 : double.parse(fileContent['weight']);
    double weightGoal = fileContent == null ? 0: double.parse(fileContent['weightGoal']);
    if (fileContent['goal'] == "Lose weight") {
      if (weightNow <= weightGoal) {
        return ("Congratulations! Goal reached.");
      } else {
        double difference = weightNow - weightGoal;
        difference = (difference * 100).round()/100.0;
        return (difference.toString() + " kg from your goal");
      }
    } else if (fileContent['goal'] == "Maintain weight") {
      if (weightNow == weightGoal) {
        return ("Congratulations! Goal reached.");
      } else {
        double difference = weightNow - weightGoal;
        difference = ((difference * 100).round()/100.0).abs();
        return (difference.toString() + "kg from your goal");
      }
    } else {
      if (weightNow >= weightGoal) {
        return ("Congratulations! Goal reached.");
      } else {
        double difference = weightGoal - weightNow;
        difference = (difference * 100).round()/100.0;
        return (difference.toString() + " kg away from your goal");
      }
    }

  }



  @override
  void initState(){
    // TODO: implement initState
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
    setUser();







    super.initState();



  }

  Future setUser() async{
    try {
      AuthService.theUser = await FirebaseAuth.instance.currentUser();
    } catch(e) {
      print("Error: " + e.toString());
    }



  }

  @override
  Widget build(BuildContext context) {

    //update();

    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: Colors.grey.shade100,
      //backgroundColor: Palette.whiteThemeBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          //margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          //padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              //"Hi, $userName",
              "Home",
              //style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            /*
            actions: <Widget>[
              IconButton(
                onPressed: (){
                  DynamicTheme.of(context).setBrightness(
                      Theme.of(context).brightness == Brightness.light
                          ? Brightness.dark
                          : Brightness.light
                  );
                },
                icon: Icon(Theme.of(context).brightness == Brightness.light
                    ? Icons.lightbulb_outline
                    : Icons.highlight
                )
              )
            ],

             */
// This is the calendar icon
          /*
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
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

                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        print("Go to calendar page");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Calendar()),
                        );
                      },
                    ),

                  )
                ],
              ),
            ],

           */


          ),
        ),
      ),
      body: fileContent == null ? Container() : Container(
        //height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [



            Stack(
              children: [

                Positioned(

                  child: Container(
                    color: Palette.miraCalPink,
                    width: MediaQuery.of(context).size.width,
                    height: 190,
                  ),
                ),


                Column(
                  children: [
                    SizedBox(height:85),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).brightness == Brightness.light ? Color(0xfffcfcfc): Color(0xff212121),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20.0, // soften the shadow
                              spreadRadius: -12, //extend the shadow
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                15.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,15,0,15),
                          child: Container(

                            child: Column(
                              children: [
                                Text("MiraCal", style: TextStyle( fontWeight: FontWeight.bold, fontSize: 40),),
                                //TextLiquidFill(text: "MiraCal"),
                                // open weight card when it's available
                                /*
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: WeightCard(),
            ),

             */


                                SizedBox(height:20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 35),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Your weight: " + showWeightDisplay(weightDisplay) + " kg",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),),
                                          SizedBox(height: 4,),
                                          fileContent == null ? Container() : Text(remainingWeight(weightDisplay),
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE39090),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        child: InkWell(
                                          onTap: (){
                                            print("Go to update weight screen");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => UpdateWeightPage()),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              //Icon(Icons.update, color: Colors.white,),
                                              SizedBox(width: 5,),
                                              Text("Update weight", style: TextStyle(color: Colors.white),),
                                              SizedBox(width: 5,),
                                            ],
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 35),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Current Goal", style: TextStyle(fontSize: 18),),
                                          fileContent == null ? Container() : Text(fileContent['goal'], style: TextStyle(fontSize: 18, color: Color(0xFFE39090), fontWeight: FontWeight.bold),),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Intensity", style: TextStyle(fontSize: 18),),
                                          fileContent == null ? Container() : Text(getIntensity(), style: TextStyle(fontSize: 18, color: Color(0xFFE39090), fontWeight: FontWeight.bold),),



                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
/*
                            FlatButton(
                              onPressed: (){
                                fetchUserData();

                              },
                              child: Text("fetch"),
                            ),


                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Divider(color: Colors.grey),
                            ),

 */
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),

            Container(
              child: Column(
                children: [
                  Image.asset(
                    "lib/assets/Exercise.gif",
                    height: 100.0,
                    width: 140.0,
                  ),

                  fileContent != null
                      ? FoodCalCard2()
                      : Container(),
                  WorkoutCalCard(),
                  SizedBox(height:20),

                ],
              ),
            )



            //Text(FoodInfo.allFoodList[0][0] + " " + FoodInfo.allFoodList[0][2]),
            //Text(FoodInfo.allFoodMap["foodID"]["nameEN"]),

            //AtAGlance(), open this when its available

          ],
        ),
      ),
      //bottomNavigationBar: NavBar(),
    );
  }


}


