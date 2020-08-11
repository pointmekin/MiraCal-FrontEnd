import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/FoodInsights.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';



import 'package:fluttertagselector/tag_class.dart';


class FoodCalCard2 extends StatefulWidget {
  @override
  _FoodCalCard2State createState() => _FoodCalCard2State();
}

class _FoodCalCard2State extends State<FoodCalCard2> with SingleTickerProviderStateMixin {


  String dropdownValue = 'Weekly';
  int caloriesEaten = 0;


  int age = 0;

  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;


  final List<Tags> tagList = [
    Tags("Label 1",Icons.map),
    Tags("Label 2",Icons.headset),
    Tags("Label 3",Icons.info),
    Tags("Label 4",Icons.cake),
    Tags("Label 5",Icons.ac_unit),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) async{
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      print(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted) this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    }).then((value) => setState((){
      String calEatenDateKey = "calEaten" + DateTime.now().toString().substring(0,10);
      fileContent[calEatenDateKey] == null ? Container() : caloriesEaten = int.parse(fileContent[calEatenDateKey]);
      dailyInfo.calEatenToday = caloriesEaten;
    }));




  }



  @override
  Widget build(BuildContext context) {
    return fileContent == null ? Container() : Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: (Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          InkWell(
            onTap: () {
              print('FoodCalCard Clicked');
              print(caloriesEaten.toString());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodInsights()),
              );

            },
            splashColor: Colors.white12,
            focusColor: Colors.white30,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.1): Colors.grey.withOpacity(0.3),
                boxShadow: [
/*
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: -15, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      10.0, // Move to bottom 10 Vertically
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
              padding: EdgeInsets.fromLTRB(20, 10, 15, 10),
              width: (MediaQuery.of(context).size.width-60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.local_dining,
                                      //color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Food",
                                      style: TextStyle(
                                          //color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(

                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  Text(dailyInfo.calEatenToday.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                  Text(" cal"),

                                ],
                              ),
                            ),
                            fileContent == null? Container() : Text(
                                "Remaining: " + remainingCal())

                            //fileContent == null? Container(): Text((int.parse(remainingCal()) > 0 ? "Remaining: " + remainingCal(): "Overate: " + remainingCal().substring(1,)), style: TextStyle(color: Colors.red),  ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),

                  Stack(
                    children: [

                      Container(

                        height: 10,
                        width: MediaQuery.of(context).size.width-100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey.shade300.withOpacity(0.5),
                        ),

                      ),

                      Container(

                        height: 10,
                        width: (dailyInfo.calEatenToday + 0.0)/(double.parse(remainingCal()) + dailyInfo.calEatenToday)* (MediaQuery.of(context).size.width-100),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Palette.miraCalPink,
                        ),

                      ),


                    ],
                  ),
                  SizedBox(height: 5),

                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  String remainingCal () {
    //double remaining = double.parse(calBMR()) - caloriesEaten;
    //return remaining.toString();
    String available = calCAL(fileContent['goal'], int.parse(calBMR()), int.parse(fileContent['weightGoalPlan']));
    int remaining = int.parse(available) - dailyInfo.calEatenToday + dailyInfo.calBurnedToday;
    return remaining.toString();


  }

  String calBMR (/*String sex, double weight, double height, int age*/){
    String sex = fileContent['gender'];
    double weight = double.parse(fileContent['weight']);
    double height = double.parse(fileContent['height']);
    age = int.parse(calculateAge());
    //height in cm, weight in kg, age in years
    if (sex == 'male') {
      return (88.362 + (13.397*weight) + (4.799*height) - (5.677*age)).round().toString();
    }else{
      return (447.593 + (9.247*weight) + (3.098*height) - (4.330*age)).round().toString();
    }

  }
  String calculateAge() {
    int age = 0;
    String birthDate = fileContent['birthdate'];
    //print("birthDate is " + birthDate);
    int yearBorn = int.parse(birthDate.substring(0,4));
    //print("date of birth is " + birthDate);
    var now = new DateTime.now();
    int yearNow = int.parse(now.toString().substring(0,4));
    //print("current date is " + now.toString());
    age = yearNow - yearBorn;

    //print("the calculated age is " + "$age");
    //if its not yet the birth month, minus 1 year from age

    int birthMonth = int.parse(birthDate.substring(5,7));
    int thisMonth = int.parse(now.toString().substring(5,7));

    if (birthMonth > thisMonth && yearBorn == yearNow) {
      age -=1;
    }

    int birthDay = int.parse(birthDate.substring(8,10));
    int thisDay = int.parse(now.toString().substring(8,10));

    //in the birth month
    if (birthMonth == thisMonth && yearBorn == yearNow) {
      if(birthDay < thisDay) {
        age -= 1;

      }
    }



    return age.toString();

  }

  String calCAL (String goal,int BMR,int option){
    //print(goal);
    //print(BMR);
    //print(option);
    /*
     goal: 'maintain','gain',lose
     option : 1 = 1 week per kg
              2 = 2 week per kg
              3 = 3 week per kg
              4 = 4 week per kg
     */
    double calperday = BMR*1.2;
    if (goal == 'Maintain weight'){ return calperday.round().toString();}
    double calgoal = (7700)/(option*7);
    if (goal == 'Gain weight') {
      return (calperday + calgoal).round().toString();
    }else if (goal == 'Lose weight'){
      return (calperday - calgoal).round().toString();
    }
  }
//print(calBMR('male',79,173,19));
//print(calBMI(79, 173));
//print(calCAL('lose',calBMR('male',79,173,19),2));

}



