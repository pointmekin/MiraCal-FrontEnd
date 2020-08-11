import 'package:flutter/material.dart';
import '../main.dart';
import 'HomeBasePage.dart';
import 'Question1.dart';
import 'Question2.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:math';


class Question3 extends StatefulWidget {
  @override
  _Question3State createState() => _Question3State();
}

class _Question3State extends State<Question3> {

  String dropdownGenderValue = 'Male';
  String dropdownAgeValue = '1';
  String dropdownHeightValue = '4';
  String dropdownWeightValue = '7';
  ///////////////////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  //////////////////////////////

  final elements1 = [
    "Lose weight",
    "Maintain weight",
    "Gain weight"
  ];

  int selectedIndex1 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }

  String calculateAge() {
    int age = 0;
    String birthDate = fileContent['birthdate'];
    print("birthDate is " + birthDate);
    int yearBorn = int.parse(birthDate.substring(0, 4));
    print("date of birth is " + birthDate);
    var now = new DateTime.now();
    int yearNow = int.parse(now.toString().substring(0, 4));
    print("current date is " + now.toString());
    age = yearNow - yearBorn;

    print("the calculated age is " + "$age");
    //if its not yet the birth month, minus 1 year from age

    int birthMonth = int.parse(birthDate.substring(5, 7));
    int thisMonth = int.parse(now.toString().substring(5, 7));

    if (birthMonth > thisMonth && yearBorn == yearNow) {
      age -= 1;
    }

    int birthDay = int.parse(birthDate.substring(8, 10));
    int thisDay = int.parse(now.toString().substring(8, 10));

    //in the birth month
    if (birthMonth == thisMonth && yearBorn == yearNow) {
      if (birthDay < thisDay) {
        age -= 1;
      }
    }

    return age.toString();
  }

  String calBMI(/*double weight, double height*/) {
    //height in cm, weigh
    double weight = double.parse(fileContent['weight']);
    double height = double.parse(fileContent['height']); // t in kg
    double BMI = (weight / pow(height / 100, 2));
    return double.parse((BMI).toStringAsFixed(2)).toString();
  }

  String calBMR(/*String sex, double weight, double height, int age*/) {
    int age = int.parse(calculateAge());
    String sex = fileContent['gender'];
    double weight = double.parse(fileContent['weight']);
    double height = double.parse(fileContent['height']);
    //height in cm, weight in kg, age in years
    if (sex == 'male') {
      return (88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age))
          .round()
          .toString();
    } else {
      return (447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age))
          .round()
          .toString();
    }
  }

  int calCAL (String goal,int BMR,int option){
    /*
     goal: 'maintain','gain',lose
     option : 1 = 1 week per kg
              2 = 2 week per kg
              3 = 3 week per kg
              4 = 4 week per kg
     */
    double calperday = BMR*1.2;
    if (goal == 'Maintain weight'){ return calperday.round();}
    double calgoal = (7700)/(option*7);
    if (goal == 'Gain weight') {
      return (calperday + calgoal).round();
    }else if (goal == 'Lose weight'){
      return (calperday - calgoal).round();
    }
  }
  //print(calBMR('male',79,173,19));
  //print(calBMI(79, 173));
  //print(calCAL('lose',calBMR('male',79,173,19),2));

  @override
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
    super.initState();
  }

  String getCalCAL() {
    print(fileContent['goal']);
    print(int.parse(calBMR()));
    print(int.parse(fileContent['weightGoalPlan']));
    int available = calCAL(fileContent['goal'], int.parse(calBMR()), int.parse(fileContent['weightGoalPlan']));
    return available.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade200,
      body: fileContent == null ? Container() : Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
            child: Column(
              children: [
                SizedBox(height: 70,),
                Text("Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),

                Container(
                  //color: Colors.grey.shade200,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: (Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [



                        InkWell(
                          onTap: () {
                            print('WeightCard Clicked');
                          },
                          //splashColor: Colors.white12,
                          //focusColor: Colors.white30,
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.3),
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
                              padding: EdgeInsets.fromLTRB(20, 10, 25, 10),
                              //height: 300,
                              width: MediaQuery.of(context).size.width-50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Text("Your BMR is " + calBMR() + " Cal/day", style: TextStyle(fontSize: 18, ),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Your BMI is " + calBMI(), style: TextStyle(fontSize: 18, ),),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Text("Food", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                  Text("You can eat " + getCalCAL() + " Calories per day.", style: TextStyle(fontSize: 18, ),),
                                  SizedBox(height: 15,),
                                  //Text("Workout", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                  //Text("(workout program goes here)", style: TextStyle(fontSize: 18, ),),

                                  SizedBox(height: 10,),



                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
                SizedBox(height:20),

              ],
            ),
          ),
          Container(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(color:Palette.miraCalPink,
                        height: 10,
                        width: MediaQuery.of(context).size.width*0.8,),
                      Container(color:Colors.grey,
                        height: 5,
                        width: MediaQuery.of(context).size.width*0,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.navigate_before, size: 40,),
                        onPressed: (){
                          if(fileContent['goal'] == "Maintain weight") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Question1()),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Question2()),
                            );
                          }

                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.navigate_next, size: 40,),
                        onPressed: (){

                          Route route = MaterialPageRoute(builder: (context) => HomeBasePage());
                          Navigator.pushReplacement(context, route);



                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
        child: _buildItem(context),
        padding: EdgeInsets.all(10.0),
      )
          : Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _buildItem(context),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title, style: TextStyle(fontSize: 16),),
    );
  }
}
