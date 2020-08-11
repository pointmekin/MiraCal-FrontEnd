import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/EditQuestion1.dart';
import 'package:flutter_app/services/Auth.dart';
import '../main.dart';
import 'Calendar.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:flutter_app/authentication/GoogleSignin.dart';

import 'SettingsPage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  final AuthService _auth = AuthService();



  int age = 0;

  String userName = "Point";
  double cardWidth;
  var whiteThemeColor = Colors.grey.shade200;
  var darkThemeColor = Colors.black;




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
    //signedIn = isSignedIn;

    //calculateAge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      //backgroundColor: whiteThemeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "Profile",

            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon:Icon(Icons.settings),
                onPressed: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );

                },
              )
            ],

          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),

                    color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade300.withOpacity(0.2): Colors.grey.withOpacity(0.3),
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
                  width: MediaQuery.of(context).size.width - 50,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Column(
                    children: [
// this is for the sign in that was delayed to version 3
////////////////////////////////////////////////////////////////////////////



                      SizedBox(height:10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30 ,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [


                            Text("Summary", style: TextStyle(fontSize: 24)),
                            FlatButton.icon(
                              icon: Icon(Icons.edit, color: Colors.grey,), //`Icon` to display
                              label:
                              Text('Edit', style: TextStyle(color: Colors.grey),), //`Text` to display
                              onPressed: () {
                                //Code to execute when Floating Action Button is clicked
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditQuestion1()),
                                );
                                //Navigator.pop(context);
                                setState(() {

                                });

                              },
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:30),
                        child: Divider(color: Colors.grey,),
                      ),

//////////////////////////////////////////////////////////////////////////////










                      SizedBox(height:10),
                      InkWell(
                        onTap: (){print("hi");},
                        //splashColor: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Weight",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  fileContent == null
                                      ? Container()
                                      : Text(
                                          fileContent['weight'] + " kg",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Weight Goal",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  fileContent == null
                                      ? Container()
                                      : Text(
                                    fileContent['weightGoal'] + " kg",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Height",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  fileContent == null
                                      ? Container()
                                      : Text(
                                          fileContent['height'] + " cm",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Age",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  fileContent == null ? Container() :
                                  Text(
                                    calculateAge(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  fileContent == null ? Container() :
                                  Text(
                                    fileContent['gender'],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "BMI",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  fileContent == null ? Container() :
                                  Text(
                                    calBMI(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "BMR",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  fileContent == null ? Container() :
                                  Text(
                                    calBMR() + " Cal",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [

                  ////////////////////////////////////////////////////
                  // this is for viewing json storage file of this app
                  // hide this before publishing

                  FlatButton.icon(
                    icon: Icon(Icons.edit), //`Icon` to display
                    label:
                    Text('Delete'), //`Text` to display
                    onPressed: () {
                      //Code to execute when Floating Action Button is clicked
                      print("deleted json file content");
                      deleteFileContent();
                      print(fileContent.toString());
                    },
                  ),

                  new Text(
                    "File content: (Removing this before releasing)",
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),

                  new Text(fileContent.toString().replaceAll(",", ",\n")),




                ],
              ),
            ),
            SizedBox(height: 10),

            InkWell(
              onTap: () {
                print('View achievements');
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Achievements()),
                );

                 */
              },
              splashColor: Colors.white12,
              focusColor: Colors.white30,
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
                  padding: EdgeInsets.fromLTRB(20, 13, 25, 10),
                  height: 50,
                  width: 380,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.book,
                                    //color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "View Achievements (Coming soon)",
                                    style: TextStyle(
                                        //color: Colors.grey.shade200,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            InkWell(
              onTap: () {
                print('Write a journal');
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Achievements()),
                );

                 */
              },
              splashColor: Colors.white12,
              focusColor: Colors.white30,
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

                       */
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(20, 13, 25, 10),
                  height: 50,
                  width: 380,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.book,
                                    //color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Write a journal (Coming soon)",
                                    style: TextStyle(
                                        //color: Colors.grey.shade200,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),

            ////////////// build library cards here
            /*
            DiaryCard(),
            DiaryCard(),
            DiaryCard(),

             */
            ////////////////
          ],
        ),
      ),
      //bottomNavigationBar: NavBar(),
    );
  }

  String calculateAge() {
    int age = 0;
    String birthDate = fileContent['birthdate'];
    //print("birthDate is " + birthDate);
    int yearBorn = int.parse(birthDate.substring(0, 4));
    //print("date of birth is " + birthDate);
    var now = new DateTime.now();
    int yearNow = int.parse(now.toString().substring(0, 4));
    //print("current date is " + now.toString());
    age = yearNow - yearBorn;

    //print("the calculated age is " + "$age");
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
    if (goal == 'maintain'){ return calperday.round();}
    double calgoal = (7700)/(option*7);
    if (goal == 'gain') {
      return (calperday + calgoal).round();
    }else if (goal == 'lose'){
      return (calperday - calgoal).round();
    }
  }
  //print(calBMR('male',79,173,19));
  //print(calBMI(79, 173));
  //print(calCAL('lose',calBMR('male',79,173,19),2));

  void deleteFileContent() {
    this.setState(() {
      fileContent = null;
      jsonFile.writeAsStringSync(json.encode(fileContent));
      fileExists = false;
    });
  }
}
