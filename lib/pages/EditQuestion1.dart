import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter_app/pages/HomeBasePage.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import '../main.dart';


enum Plans { one, two, three, four }

class EditQuestion1 extends StatefulWidget {
  @override
  _EditQuestion1State createState() => _EditQuestion1State();
}

String MIN_DATETIME = '1920-01-11';
String MAX_DATETIME = '2030-11-25';
String INIT_DATETIME = '2030-12-31';

class _EditQuestion1State extends State<EditQuestion1> {

  ////////////////////////////
  // IMPORTANT STATES TO SAVE
  String dropdownGenderValue = 'Male';
  DateTime birthDate;
  String weightInput;
  String heightInput;
  String goal;
  String dropdownDurationValue = '1 Week';
  String dropdownGoalValue = 'Lose weight';
  String weightGoal;
  Plans _plan;
  int weightGoalPlan = 1;
  bool validWeightGoal = true;
  bool showWeightGoalErrorMessage = false;
  String errorMessage;
  bool showErrorMessage = false;
  bool validHeight = true;
  bool showHeightErrorMessage = false;
  bool validWeight = true;
  bool showWeightErrorMessage = false;
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

  bool _showTitle = true;

  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  List<DateTimePickerLocale> _locales = DateTimePickerLocale.values;

  String _format = 'yyyy-MMMM-dd';
  TextEditingController _formatCtrl = TextEditingController();

  DateTime _dateTime;




  final elements1 = ["Lose weight", "Maintain weight", "Gain weight"];

  int selectedIndex1 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
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
              onPressed: () {

                print("validWeightGoal" + validWeightGoal.toString());
                print("validHeight" + validHeight.toString());
                print("validWeight" + validWeight.toString());

                if (validWeightGoal && validHeight && validWeight) {

                  Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
                  //fileContent['weight'] = "70"; // this one is specific to this profile page


                  jsonFileContent['gender'] = fileContent['gender'];
                  jsonFileContent['height'] = fileContent['height'];
                  jsonFileContent['weight'] = fileContent['weight'];
                  jsonFileContent['birthdate'] = fileContent['birthdate'];
                  jsonFileContent['goal'] = fileContent['goal'];
                  jsonFileContent['weightGoal'] = fileContent['weightGoal'];
                  jsonFileContent['goalDuration'] = fileContent['goalDuration'];
                  jsonFileContent['weightGoalPlan'] = fileContent['weightGoalPlan'];
                  // this edits the original json data source
                  jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this saves the json

                  Navigator.pop(context);
                  setState(() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeBasePage()),
                    );
                  });
                } else {
                  print('invalid bitches');
                  _showErrorDialog();
                }

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  String getWarningMessage() {
    String warningMessage = "Warning Message";

    int available = calCAL(fileContent['goal'], int.parse(calBMR()), weightGoalPlan);
    warningMessage = "Current plan: " + available.toString() + " Calories." + "\nEating less than 1200 Calories per day can be challenging. Do you wish to proceed?";


    return warningMessage;
  }

  String getGoal() {
    return fileContent['goal'];
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
    super.initState();
    _formatCtrl.text = _format;
    MAX_DATETIME = DateTime.now().toString().substring(0,10);
    INIT_DATETIME = DateTime.now().toString().substring(0,10);
    //_dateTime = DateTime.parse(INIT_DATETIME);

    //Json information storing stuff
    //deleteFileContent();
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    }).then((value) => (){setState(() {

      if (fileContent['weightGoalPlan'] == "1") {
        setState(() {
          _plan = Plans.one;
          weightGoalPlan = 1;
        });

      } else if (fileContent['weightGoalPlan'] == "2") {
        setState(() {
          _plan = Plans.two;
          weightGoalPlan = 2;
        });

        print("Set to 2");
      } else if (fileContent['weightGoalPlan'] == "3") {
        setState(() {
          _plan = Plans.three;
          weightGoalPlan = 3;
        });

      } else if (fileContent['weightGoalPlan'] == "4") {
        setState(() {
          _plan = Plans.four;
          weightGoalPlan = 4;
        });

      }
    });});


  }

  @override
  void dispose() {
    keyInputController.dispose();
    valueInputController.dispose();
    super.dispose();
  }


  void createFile(Map<String, dynamic> content, Directory dir, String fileName) {
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
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
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

  void deleteFileContent(){
    this.setState(() {
      fileContent = null;
      jsonFile.writeAsStringSync(json.encode(fileContent));
      fileExists = false;
      keyInputController.clear();
      valueInputController.clear();


    });
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
              "Edit Profile",
              //style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,

          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(

              child: Column(

                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tell us about yourself",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Palette.miraCalPink,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    //color: Colors.grey.shade200,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: (Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: InkWell(
                              onTap: () {
                                print('WeightCard Clicked');
                              },
                              //splashColor: Colors.white12,
                              //focusColor: Colors.white30,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.1): Colors.grey.withOpacity(0.3),
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
                                width: MediaQuery.of(context).size.width - 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Birth Gender",
                                                  style: TextStyle(
                                                      //color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          DropdownButton<String>(
                                            value: dropdownGenderValue,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              //color: Colors.black,
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            //dropdownColor: Colors.grey.shade200,

                                            underline: Container(
                                              height: 2,
                                              //color: Colors.black,
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownGenderValue = newValue;
                                                fileContent['gender'] = dropdownGenderValue;
                                                print(
                                                    "change to $dropdownGenderValue view");

                                              });
                                            },
                                            items: <String>['Male', 'Female']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,

                                                    ),
                                                  );
                                                }).toList(),
                                          ),
                                        ]),

                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Height (cm)",
                                                  style: TextStyle(
                                                      //color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            child: Form(
                                              autovalidate: true,
                                              onChanged: () {
                                                Form.of(primaryFocus.context).save();
                                              },
                                              child: TextFormField(
                                                keyboardType: TextInputType.number,
                                                initialValue: fileContent['height'],
                                                controller: heightInputController,

                                                decoration: const InputDecoration(

                                                  hintText: 'ex: 180',

                                                ),
                                                onChanged: (String value){

                                                  if (value == '' || value.contains(",")  || value.contains("-")){
                                                    setState(() {
                                                      validHeight = false;
                                                      showHeightErrorMessage = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      validHeight = true;
                                                      showHeightErrorMessage = false;
                                                      heightInput = value;
                                                      print("height is " + heightInput);
                                                    });


                                                  }

                                                  value == '' ? heightInput = '0' :heightInput = value;
                                                  fileContent['height'] = heightInput;
                                                  print("height is " + heightInput);
                                                },
                                                onSaved: (String value) {
                                                  // This optional block of code can be used to run
                                                  // code when the user saves the form.
                                                  // code when the user saves the form.
                                                  print("saved");
                                                },

                                                validator: (String value) {
                                                  return value.contains('@') ? 'Do not use the @ char.' : null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ]),
                                    showHeightErrorMessage ? Text("Invalid height", style: TextStyle(color: Colors.red),) : Container(),
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Weight (kg)",
                                                  style: TextStyle(
                                                      //color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            child: TextFormField(
                                              keyboardType: TextInputType.number,
                                              initialValue: fileContent['weight'],
                                              decoration: const InputDecoration(

                                                hintText: 'ex: 70',

                                              ),
                                              onChanged: (String value){

                                                if (value == '' || value.contains(",") || value.contains("-")){
                                                  setState(() {
                                                    validWeight = false;
                                                    showWeightErrorMessage = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    validWeight = true;
                                                    showWeightErrorMessage = false;
                                                    weightInput = value;
                                                    print("weight is " + weightInput);
                                                  });


                                                }

                                                value == '' ? weightInput = '0' : weightInput = value;
                                                fileContent['weight'] = weightInput;
                                                print("weight is " + weightInput);
                                              },
                                              onSaved: (String value) {
                                                // This optional block of code can be used to run
                                                // code when the user saves the form.
                                                print("weight saved");
                                              },
                                              validator: (String value) {
                                                return value.contains('@') ? 'Do not use the @ char.' : null;
                                              },
                                            ),
                                          ),
                                        ]),
                                    SizedBox(height: 5,),
                                    showWeightErrorMessage ? Text('Invalid weight', style: TextStyle(color: Colors.red),) : Container(),
                                    Divider(color: Colors.grey),
                                    SizedBox(height: 10,),
                                    Container(

                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Birth Date:',
                                            style: TextStyle(
                                                //color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 12.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          fileContent['birthdate'].substring(0,10)
                                                      ),
                                                      /*
                                                      Text(
                                                        '${_dateTime.year}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),

                                                       */
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      InkWell(
                                                        child: Text("edit", style: TextStyle(color: Colors.grey),),
                                                        onTap: () {
                                                          _showDatePicker();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "What is your goal?",
                      style: TextStyle(
                          color: Palette.miraCalPink,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.1): Colors.grey.withOpacity(0.3),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("I want to: ", style: TextStyle(fontSize: 18),),
                            DropdownButton<String>(

                              value: fileContent['goal'],
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                //color: Colors.black,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              //dropdownColor: Colors.grey.shade200,

                              underline: Container(
                                height: 2,
                                //color: Colors.black,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownGoalValue = newValue;
                                  fileContent['goal'] = dropdownGoalValue;
                                  print(
                                      "change to $dropdownGoalValue view");

                                });
                              },
                              items: <String>['Lose weight', 'Maintain weight', 'Gain weight']
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,

                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
/* // this is the old direct select interface for choosing goal
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DirectSelect(
                        itemExtent: 45.0,
                        selectedIndex: selectedIndex1,
                        backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white: Colors.grey,

                        child: MySelectionItem(

                          isForList: false,
                          title: elements1[elements1.indexOf(fileContent['goal'])],
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedIndex1 = index;
                            goal = elements1[selectedIndex1];
                            fileContent['goal'] = goal;
                          });
                        },
                        items: _buildItems1()),
                  ),

 */
                  SizedBox(height: 30),
                  fileContent == null ? Container() : selectedIndex1 == 1 || fileContent['goal'] == "Maintain weight" ? Container() :
                  Container(
                    child: Column(
                      children: [
                        Text("Tell us about your goal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Palette.miraCalPink,),),
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
                                        color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.1): Colors.grey.withOpacity(0.3),
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

                                      width: MediaQuery.of(context).size.width-50,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 15,),
                                          Text(
                                            "What is your weight goal?",
                                            style: TextStyle(
                                                //color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),


                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            child: Form(
                                              autovalidate: true,
                                              onChanged: () {
                                                Form.of(primaryFocus.context).save();
                                              },
                                              child: TextFormField(
                                                keyboardType: TextInputType.number,

                                                initialValue: fileContent['weightGoal'],
                                                decoration: const InputDecoration(

                                                  hintText: 'ex: 70 kg',

                                                ),
                                                onChanged: (String value){
                                                  weightGoal = value;
                                                  fileContent['weightGoal'] = weightGoal;
                                                  print("height is " + weightGoal);

                                                  if (value == '' || value.contains(",") || value.contains("-")){
                                                    setState(() {
                                                      validWeightGoal = false;
                                                      showWeightGoalErrorMessage = true;
                                                    });
                                                  } else {
                                                    setState(() {

                                                      String goal = fileContent['goal'];
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
                                          SizedBox(height: 5,),
                                          showWeightGoalErrorMessage ? Text("Invalid weight goal", style: TextStyle(color: Colors.red),): Container(),
                                          showErrorMessage ? Text(errorMessage, style: TextStyle(color: Colors.red),): Container(),
                                          SizedBox(height: 10,),
                                          Text(
                                            "How fast do you want to " + getGoal().toLowerCase() + "?",
                                            //"How fast do you want to",
                                            style: TextStyle(
                                                //color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                title: const Text("1 kg in 1 week"),
                                                leading: Radio(
                                                  value: Plans.one,
                                                  groupValue: _plan,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _plan = value;
                                                      weightGoalPlan = 1;
                                                      print(weightGoalPlan);
                                                      fileContent['weightGoalPlan'] = "1";
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
                                                      fileContent['weightGoalPlan'] = "2";
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
                                                      fileContent['weightGoalPlan'] = "3";
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
                                                      fileContent['weightGoalPlan'] = "4";
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(height:5),
                                              Divider(color: Colors.grey,),
                                              Text("Current plan: "+calCAL(fileContent['goal'], int.parse(calBMR()), int.parse(fileContent['weightGoalPlan'])).toString() + " Calories per day"),

                                            ],
                                          ),
                                          //SizedBox(height: 20,),



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
                        dropdownDurationValue == '7' ? InkWell(
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
                              height: 140,
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

                ],
              ),
            ),
            Container(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        FlatButton.icon(
                          icon: Icon(
                            Icons.check,
                            //color: Colors.black,
                            //size: 40,
                          ),
                          label: Text("Save"),
                          onPressed: () {
                            if (validWeightGoal && validHeight && validWeight) {
                              if (calCAL(fileContent['goal'], int.parse(calBMR()), int.parse(fileContent['weightGoalPlan'])) < 1200) {
                                _showWarningDialog();
                              } else {

                                if (validWeightGoal && validHeight && validWeight) {

                                  Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
                                  //fileContent['weight'] = "70"; // this one is specific to this profile page




                                  jsonFileContent['gender'] = fileContent['gender'];
                                  jsonFileContent['height'] = fileContent['height'];
                                  jsonFileContent['weight'] = fileContent['weight'];
                                  jsonFileContent['birthdate'] = fileContent['birthdate'];
                                  jsonFileContent['goal'] = fileContent['goal'];
                                  jsonFileContent['weightGoal'] = fileContent['weightGoal'];
                                  jsonFileContent['goalDuration'] = fileContent['goalDuration'];
                                  jsonFileContent['weightGoalPlan'] = fileContent['weightGoalPlan'];

                                  if (fileContent['goal'] == "Maintain weight") {
                                    jsonFileContent['weightGoal'] = fileContent['weight'];

                                  }


                                  // this edits the original json data source
                                  jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this saves the json

                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeBasePage()),
                                  );

                                  Fluttertoast.showToast(
                                      msg: "Saved",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.withOpacity(0.5),
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );

                                } else {
                                  print('invalid bitches');
                                  _showErrorDialog();
                                }

                              }

                            } else {
                              _showErrorDialog();
                            }





                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }




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

  void saveInfoToJsonFile() {
    writeToFile("test", "test");
  }


  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.3),
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
          fileContent['birthdate'] = _dateTime.toString().substring(0,10);
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
