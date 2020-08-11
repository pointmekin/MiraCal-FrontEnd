import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/pages/Question1.dart';
import '../main.dart';
import 'Question3.dart';

enum Plans { one, two, three, four }

class Question2 extends StatefulWidget {
  @override
  _Question2State createState() => _Question2State();
}

class _Question2State extends State<Question2> {

  /////////////////////
  //IMPORTANT STATES TO SAVE
  String dropdownDurationValue = '1 Week';
  String weightGoal;
  bool validWeightGoal = false;
  bool showWeightGoalErrorMessage = false;
  String errorMessage;
  bool showErrorMessage = false;
  //bool validWeightGoalDuration = false;
  //bool showWeightGoalDurationMessage = false;
  String weightGoalDuration;
  int weightGoalPlan = 1;
  String goal = "";
  bool theyCanDoIt = false;


  ////////////////////
  ///////////////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  String defaultHeight;

  ////////////////////////////



  int selectedIndex1 = 0;

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid input'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please fill in the form with valid values.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();




              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showWarningDialog() async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("MiraCal Suggestion"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(getWarningMessage()),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Change plan'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),FlatButton(
              child: Text('I can do it!'),
              onPressed: () async {

                setState(() {
                  theyCanDoIt = true;
                });

                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

  void iCanDoIt() async {
    print("valid");
    writeToFile("weightGoal", double.parse(weightGoal).toString());
    writeToFile("goalDuration", weightGoalDuration);
    writeToFile("weightGoalPlan", weightGoalPlan.toString());
    writeToFile("weightGoalPlan", weightGoalPlan.toString());
  }

  String getGoal() {
    return fileContent['goal'];
  }

  String getWarningMessage() {
    String warningMessage = "Warning Message";

    int available = calCAL(fileContent['goal'], int.parse(calBMR()), weightGoalPlan);
    warningMessage = "Current plan: " + available.toString() + " Calories." + "\nEating less than 1200 Calories per day can be challenging. Do you wish to proceed?";


    return warningMessage;
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



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    }).then((value) => (){setState(() {
      weightGoalPlan = 1;
      print(weightGoalPlan);
    });});
  }


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

  Plans _plan = Plans.one;


  @override
  Widget build(BuildContext context) {
    return fileContent == null ? Container() : Scaffold(
      //backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 70,),
                    Text("Tell us about your goal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                                  //height: 220,
                                  width: MediaQuery.of(context).size.width-50,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15,),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "What is your weight goal?",
                                                    style: TextStyle(
                                                        //color: Colors.black,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ]),


                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Form(
                                          autovalidate: true,
                                          onChanged: () {
                                            Form.of(primaryFocus.context).save();
                                          },
                                          child: TextFormField(
                                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                                            decoration: const InputDecoration(

                                              hintText: 'ex: 70 kg',

                                            ),
                                            onChanged: (String value){
                                              if (value == '' || value.contains(",") || value.contains("-")){
                                                setState(() {
                                                  validWeightGoal = false;
                                                  showWeightGoalErrorMessage = true;
                                                });
                                              } else {
                                                setState(() {

                                                  String goal = fileContent['goal'];
                                                  print("Goal: " + goal);

                                                  if (goal == "Lose weight") {
                                                    if (double.parse(value) >= double.parse(fileContent['weight'])){
                                                      setState(() {
                                                        errorMessage = "To lose weight, your weight goal cannot be higher than your current weight.";
                                                        showErrorMessage = true;
                                                      });

                                                    } else {setState(() {
                                                      showErrorMessage = false;
                                                    });}

                                                  } else if (goal == "Maintain weight"){

                                                    if (double.parse(value) != double.parse(fileContent['weight'])){
                                                      setState(() {
                                                        errorMessage = "To maintain weight, your weight goal must be equal to your current weight.";
                                                        showErrorMessage = true;
                                                      });

                                                    }

                                                  } else {
                                                    if (double.parse(value) <= double.parse(fileContent['weight'])){
                                                      setState(() {
                                                        errorMessage = "To gain weight, your weight goal cannot be lower than your current weight.";
                                                        showErrorMessage = true;
                                                      });

                                                    } else {
                                                      setState(() {
                                                        showErrorMessage = false;
                                                      });
                                                    }



                                                  }

                                                  validWeightGoal = true;
                                                  showWeightGoalErrorMessage = false;
                                                  weightGoal = value;
                                                  print("height is " + weightGoal);
                                                });


                                              }

                                            },
                                            onSaved: (String value) {
                                              // This optional block of code can be used to run
                                              // code when the user saves the form.
                                              print("saved");
                                            },

                                            validator: (String value) {
                                              return value.contains('@') ? 'Do not use the @ char.' : null;
                                            },
                                          ),
                                        ),
                                      ),
                                      showWeightGoalErrorMessage ? Text("invalid weight goal", style: TextStyle(color: Colors.red),) : Container(),
                                      SizedBox(height: 15,),
                                      Text(
                                      "How fast do you want to " + getGoal().toLowerCase() + "?",
                                        //"How fast do you want to",
                                        style: TextStyle(
                                            //color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      ),
                                      Column(
                                        children: [
                                          ListTile(
                                            title: const Text("1 kg in 1 week"),
                                            leading: Radio(
                                              activeColor: Palette.miraCalPink,
                                              value: Plans.one,
                                              groupValue: _plan,
                                              onChanged: (value) {
                                                setState(() {
                                                  _plan = value;
                                                  weightGoalPlan = 1;
                                                  print(weightGoalPlan);
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: const Text("1 kg in 2 weeks"),
                                            leading: Radio(
                                              value: Plans.two,
                                              groupValue: _plan,
                                              onChanged: (value) {
                                                setState(() {
                                                  _plan = value;
                                                  weightGoalPlan = 2;
                                                  print(weightGoalPlan);
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: const Text("1 kg in 3 weeks"),
                                            leading: Radio(
                                              value: Plans.three,
                                              groupValue: _plan,
                                              onChanged: (value) {
                                                setState(() {
                                                  _plan = value;
                                                  weightGoalPlan = 3;
                                                  print(weightGoalPlan);
                                                });
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: const Text("1 kg in 4 weeks"),
                                            leading: Radio(
                                              value: Plans.four,
                                              groupValue: _plan,
                                              onChanged: (value) {
                                                setState(() {
                                                  _plan = value;
                                                  weightGoalPlan = 4;
                                                  print(weightGoalPlan);
                                                });
                                              },
                                            ),
                                          ),

                                        ],
                                      ),
                                      /*
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.15,
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              decoration: const InputDecoration(

                                                hintText: '30',

                                              ),
                                              onChanged: (String value){
                                                if (value == '' || value.contains(",") || value.contains("-")){
                                                  setState(() {
                                                    validWeightGoal = false;
                                                    showWeightGoalErrorMessage = true;
                                                  });
                                                } else {
                                                  setState(() {

                                                    String goal = fileContent['weightGoal'];
                                                    if (goal == "Lose weight") {
                                                      if (double.parse(value) > double.parse(fileContent['weight'])){
                                                        setState(() {
                                                          errorMessage = "To lose weight, your weight goal cannot be higher than your current weight.";
                                                          showErrorMessage = true;
                                                        });

                                                      } else {setState(() {
                                                        showErrorMessage = false;
                                                      });}

                                                    } else if (goal == "Maintain weight"){


                                                    } else {
                                                      if (double.parse(value) > double.parse(fileContent['weight'])){
                                                        setState(() {
                                                          errorMessage = "To gain weight, your weight goal cannot be lower than your current weight.";
                                                          showErrorMessage = true;
                                                        });

                                                      } else {
                                                        setState(() {
                                                          showErrorMessage = false;
                                                        });
                                                      }



                                                    }

                                                    validWeightGoalDuration = true;
                                                    showWeightGoalDurationMessage = false;
                                                    weightGoalDuration = value;
                                                    print("duration is " + weightGoalDuration);
                                                  });


                                                }

                                              },
                                              onSaved: (String value) {
                                                // This optional block of code can be used to run
                                                // code when the user saves the form.
                                                print("saved");
                                              },

                                              validator: (String value) {
                                                return value.contains('@') ? 'Do not use the @ char.' : null;
                                              },
                                            ),
                                          ),
                                          Text(" days"),
                                        ],
                                      ),
                                      showWeightGoalErrorMessage ? Text("invalid duration", style: TextStyle(color: Colors.red),) : Container(),
                                      */
                                      /*

                                      DropdownButton<String>(
                                        value: dropdownDurationValue,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                        iconSize: 24,
                                        elevation: 16,
                                        dropdownColor: Colors.grey.shade200,
                                        style: TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.black,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownDurationValue = newValue;
                                            print("change to $dropdownDurationValue view");
                                          });
                                        },
                                        items: <String>['1 Week', '2 Weeks', '3 Weeks', '1 month', '2 Months', '3 Months', '4 Months', '5 Months', '6 Months', '1 Year']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),

                                       */
                                      SizedBox(height: 10,),
                                      showErrorMessage ? Text("$errorMessage", style: TextStyle(color: Colors.red),) : Container(),
                                      SizedBox(height: 10,),
                                      Divider(color: Colors.grey,),
                                      Text("Current plan: "+calCAL(fileContent['goal'], int.parse(calBMR()), weightGoalPlan).toString() + " Calories per day"),




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

                    // This is the error message preview
                    /*

                    calCAL(fileContent['goal'], int.parse(calBMR()), weightGoalPlan) < 1200
                        ? Text(getWarningMessage(), style: TextStyle(color: Colors.orange),)
                        : Container(),

                     */

                    dropdownDurationValue == '7' ? InkWell(
                      onTap: () {
                        print('WeightCard Clicked');
                      },
                      splashColor: Colors.white12,
                      focusColor: Colors.white30,
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            //color: Colors.grey.shade200,
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
                          //height: 140,
                          width: 380,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),

                              Text(
                                "Warning",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(height:10),
                              Text(
                                "This goal might be difficult to accomplish. Click next to proceed anyway.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18),
                              ),
                              //SizedBox(height: 20,),



                            ],
                          ),
                        ),
                      ),
                    ) : Container(),

                    /*
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "What is your goal?",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(height:20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: DirectSelect(

                          itemExtent: 35.0,

                          selectedIndex: selectedIndex1,
                          backgroundColor: Colors.grey.shade200,
                          child: MySelectionItem(
                            isForList: false,
                            title: elements1[selectedIndex1],
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedIndex1 = index;
                            });
                          },
                          items: _buildItems1()),
                    ),

                     */
                    SizedBox(height:20),

                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    InkWell(
                      child: Text("(Coming soon) Need help setting your goal?", style: TextStyle(color: Colors.grey.shade400/*Color(0xFFE39090)*/, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),),
                      onTap: (){
                        /*
                        print("go to question 2.5");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Question2point5()),
                        );

                         */
                      },
                    ),
                    SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(color:Palette.miraCalPink,
                            height: 10,
                            width: MediaQuery.of(context).size.width*0.5,),
                          Container(color:Colors.grey,
                            height: 5,
                            width: MediaQuery.of(context).size.width*0.3,),
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Question1()),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.navigate_next, size: 40,),
                            onPressed: (){

                              if (!showErrorMessage) {

                                if (calCAL(fileContent['goal'], int.parse(calBMR()), weightGoalPlan) > 1200) {
                                  setState(() {
                                    theyCanDoIt = true;
                                  });
                                }
                                if (!validWeightGoal) {
                                  _showErrorDialog();
                                } else {
                                  if (!theyCanDoIt && calCAL(fileContent['goal'], int.parse(calBMR()), weightGoalPlan) < 1200) {
                                    _showWarningDialog();
                                  } else {
                                    if(validWeightGoal && theyCanDoIt) {
                                      print("valid");
                                      writeToFile("weightGoal", double.parse(weightGoal).toString());
                                      writeToFile("goalDuration", weightGoalDuration);
                                      writeToFile("weightGoalPlan", weightGoalPlan.toString());
                                      writeToFile("weightGoalPlan", weightGoalPlan.toString());

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => Question3()),
                                      );

                                    } else {
                                      print('invalid bitches');
                                      _showErrorDialog();
                                    }

                                  }
                                }

                              }

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
        ),
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
