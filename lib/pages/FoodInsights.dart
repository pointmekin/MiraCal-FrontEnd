import 'package:flutter/material.dart';
import 'package:flutter_app/components/foodCalCard.dart';
import 'package:flutter_app/components/foodCalCard2.dart';
import 'package:flutter_app/components/foodCalCard2NoTouch.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/WorkoutSearch.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'FoodSearch2.dart';

class FoodInsights extends StatefulWidget {
  @override
  _FoodInsightsState createState() => _FoodInsightsState();
}

const String MIN_DATETIME = '1990-01-11';
const String MAX_DATETIME = '2030-11-25';
const String INIT_DATETIME = '2030-05-17';

class _FoodInsightsState extends State<FoodInsights> with SingleTickerProviderStateMixin{
  ////////////////////////////
  // IMPORTANT STATES TO SAVE
  String dropdownGenderValue = 'Male';
  DateTime birthDate;
  String weightInput;
  String heightInput;
  String goal;
  String dropdownDurationValue = '1 Week';
  String weightGoal;
  String newWeight;
  String dateKey;
  String calEatenDateKey;
  String foodEatenDateKey;
  List<List<String>> tempFoodEatenDateKey;
  String calEatenToday = '';
  ///////////////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  String defaultHeight;

  ////////////////////////////

  TextEditingController keyInputController = new TextEditingController();
  TextEditingController valueInputController = new TextEditingController();
  TextEditingController heightInputController;
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;


  bool _showTitle = true;

  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  List<DateTimePickerLocale> _locales = DateTimePickerLocale.values;

  String _format = 'yyyy-MMMM-dd';
  TextEditingController _formatCtrl = TextEditingController();

  DateTime _dateTime;

  final elements1 = ["Lose weight", "Maintain weight", "Gain weight"];

  int selectedIndex1 = 0;
/*
  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }
*/
  @override
  void initState() {
    super.initState();
    _formatCtrl.text = _format;
    //_dateTime = DateTime.parse(INIT_DATETIME);

    //Json information storing stuff
    //deleteFileContent();
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    }).then((value) => setState(() {
      newWeight = fileContent['weight'];
      dateKey = "weight" + DateTime.now().toString().substring(0,10);

      calEatenDateKey = "calEaten" + DateTime.now().toString().substring(0,10);

      foodEatenDateKey = "foodEaten" + DateTime.now().toString().substring(0,10);


      //decode

        final regExp = new RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
        String temp = fileContent[foodEatenDateKey];
        final input = temp;
        var result = regExp.allMatches(input).map((m) => m.group(1))
            .map((String item) => item.replaceAll(new RegExp(r'[\[\],]'), ''))
            .map((m) => [m])
            .toList();
        print(result);
        var result2 = regExp.allMatches(result.toString()).map((m) => m.group(1))
            .map((String item) => item.replaceAll(new RegExp(r'[\[\],]'), ''))
            .map((m) => [m])
            .toList();
        print(result2);

      setState(() {
        tempFoodEatenDateKey = result2;
        calEatenToday = fileContent[calEatenDateKey];

      });

    }));

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,

    ));

    _controller.forward();


  }

  @override
  void dispose() {
    super.dispose();
    keyInputController.dispose();
    valueInputController.dispose();
    _controller.dispose();

  }


  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
    keyInputController.clear();
    valueInputController.clear();
  }

  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
      json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      //createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);
    keyInputController.clear();
    valueInputController.clear();
  }

  void deleteFileContent() {
    this.setState(() {
      fileContent = null;
      jsonFile.writeAsStringSync(json.encode(fileContent));
      fileExists = false;
      keyInputController.clear();
      valueInputController.clear();
    });
  }

  int getCuttingIndex(String foodNameAndCal) {
    return foodNameAndCal.lastIndexOf(" ");

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomPadding: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "Today's Calorie Intake",
              //style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: fileContent == null ? Container() : SingleChildScrollView(
        //height: MediaQuery.of(context).size.height,
        //width: MediaQuery.of(context).size.width,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  /*
                  Row(
                    children: [
                      Text(DateTime.now().toString().substring(0,10), style: TextStyle(fontSize: 24),),
                    ],
                  ),

                   */

                  SlideTransition(
                      position: _offsetAnimation,
                      child: FoodCalCard2NoTouch()
                  ),

                  SizedBox(height: 10,),

                  fileContent[foodEatenDateKey] == null || fileContent[calEatenDateKey] == null
                      ? Column(
                        children: [
                          Text("You have not eaten anything today."),
                          SizedBox(height: 10),
                          Divider(color: Colors.grey,),
                          SizedBox(height: 10,)
                        ],
                      )
                      :Column(
                    children: [
                      /*

                      Row(
                        children: [
                          Text('Net Calories eaten today'),
                        ],
                      ),
                      Row(
                        children: [
                          Text(calEatenToday, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Palette.miraCalPink),),
                          Text(" / " +calCAL(fileContent['goal'], int.parse(calBMR()), int.parse(fileContent['weightGoalPlan'])) +"Cal"),
                        ],
                      ),


                      SizedBox(height:10),

                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        height: 10,
                        child: Row(
                          children: [
                            Container(
                              color: Color(0xFFE39090),
                              width: (MediaQuery.of(context).size.width - 60) * (double.parse(fileContent[calEatenDateKey]) > double.parse(calCAL(fileContent['goal'], int.parse(calBMR()), int.parse(fileContent['weightGoalPlan']))) ?  1: double.parse(calEatenToday) / double.parse(calCAL(fileContent['goal'], int.parse(calBMR()), int.parse(fileContent['weightGoalPlan'])))),
                            ),
                            Container(
                              color: Colors.grey.shade300.withOpacity(0.5),
                              width: (MediaQuery.of(context).size.width - 60) * (double.parse(fileContent[calEatenDateKey]) > double.parse(calCAL(fileContent['goal'], int.parse(calBMR()), int.parse(fileContent['weightGoalPlan']))) ? 0 : 1 - double.parse(calEatenToday) / double.parse(calCAL(fileContent['goal'], int.parse(calBMR()), int.parse(fileContent['weightGoalPlan'])))),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: double.parse(fileContent[calEatenDateKey]) > double.parse(calBMR()) ? Text("You have gone over the limit by " +
                            (double.parse(fileContent[calEatenDateKey]) - double.parse(calBMR())).toString() + " Calories."
                        ): Container(),
                      ),

                       */
                      //SizedBox(height: 20,),
                      //Divider(color: Colors.black54),
                      SizedBox(height:30),
                      Row(
                        children: [
                          Text("Food Eaten Today", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        //controller: _controller,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: tempFoodEatenDateKey.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            //height: 280,
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:MediaQuery.of(context).size.width * 0.50,
                                          child: tempFoodEatenDateKey == null ? Container() : Text(

                                              tempFoodEatenDateKey[index][0].substring(0,getCuttingIndex(tempFoodEatenDateKey[index][0])), style: TextStyle(fontSize: 18),)
                                      ),
                                      Text(tempFoodEatenDateKey[index][0].substring(getCuttingIndex(tempFoodEatenDateKey[index][0])) + " Cal", style: TextStyle(fontSize: 18),),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: (){
                                          setState(() {




                                            Map<String, dynamic> jsonFileContent =
                                            json.decode(jsonFile.readAsStringSync());

                                            jsonFileContent[calEatenDateKey] = (double.parse(fileContent[calEatenDateKey]) - double.parse(tempFoodEatenDateKey[index][0].substring(getCuttingIndex(tempFoodEatenDateKey[index][0])))).toString();
                                            calEatenToday = (double.parse(calEatenToday) - double.parse(tempFoodEatenDateKey[index][0].substring(getCuttingIndex(tempFoodEatenDateKey[index][0])))).toString();

                                            tempFoodEatenDateKey.remove(tempFoodEatenDateKey[index]);

                                            if (tempFoodEatenDateKey.length == 0) {
                                              setState(() {
                                                //print(tempFoodEatenDateKey);
                                                dailyInfo.calEatenToday = 0;
                                                jsonFileContent.remove(calEatenDateKey);
                                                jsonFileContent.remove(foodEatenDateKey);
                                              });
                                            } else {
                                              jsonFileContent[foodEatenDateKey] = tempFoodEatenDateKey.toString();
                                              //print(tempFoodEatenDateKey);
                                              //jsonFileContent[foodEatenDateKey] = tempFoodEatenDateKey.toString();
                                            }


                                            //print(tempFoodEatenDateKey);

                                            jsonFile.writeAsStringSync(json.encode(jsonFileContent));

                                            dailyInfo.calEatenToday = int.parse(double.parse(calEatenToday).round().toString());

                                            Fluttertoast.showToast(
                                                msg: "Removed",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.grey.withOpacity(0.5),
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );


                                          });

                                        },

                                      )
                                    ],

                                  ),
                                  SizedBox(height: 5,),
                                  Divider(color: Colors.grey.shade400,)
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
            // this is the button that redirects to the search page
            /*
            Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      print('go to FoodSearch Page');
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodSearch2()),
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
                          color: Color(0xFFE39090),
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
                                          Icons.track_changes,
                                          color: Colors.grey.shade200,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Record new food intake",
                                          style: TextStyle(
                                              color: Colors.grey.shade200,
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
                  SizedBox(height: 30,),
// this is for testing purposes, displaying all contents of the json file
                /*
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30),
                    child: Text(fileContent.toString()),
                  ),
                  
                 */
                ],
              ),
            )

             */
          ],
        ),
      ),

    );
  }

  void saveInfoToJsonFile() {
    writeToFile("test", "test");
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        //backgroundColor: Colors.grey.shade200,
        showTitle: _showTitle,
        confirm: Text('Done', style: TextStyle(color: Colors.black)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: _locale,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
          birthDate = _dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
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
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
