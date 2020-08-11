import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/Question3.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'Question2.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Question1 extends StatefulWidget {
  @override
  _Question1State createState() => _Question1State();
}

const String MIN_DATETIME = '1920-01-11';
const String MAX_DATETIME = '2030-11-25';
const String INIT_DATETIME = '2030-05-17';

class _Question1State extends State<Question1> {

  ////////////////////////////
  // IMPORTANT STATES TO SAVE
  String dropdownGenderValue = 'Male';
  DateTime birthDate;
  String weightInput;
  String heightInput;
  String goal ;
  bool allowNext = false; // for the next button
  bool validHeight = false;
  bool showHeightErrorMessage = false;
  bool validWeight = false;
  bool showWeightErrorMessage = false;
  bool validBirthdate = false;
  String dropdownGoalValue = "Lose weight";
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
      if (fileExists) this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
    setState(() {
      goal = elements1[selectedIndex1];
      print(goal);
    });


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
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    print(fileContent);
    keyInputController.clear();
    valueInputController.clear();
    goal = elements1[selectedIndex1];
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
      body: Scrollbar(
        child: SingleChildScrollView(


          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Container(
                  //height: MediaQuery.of(context).size.height,
                  child: Column(

                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        "Tell us about yourself",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        //color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.3),
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
                                  splashColor: Colors.white12,
                                  focusColor: Colors.white30,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
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
                                                //style: TextStyle(color: Colors.deepPurple),
                                                underline: Container(
                                                  height: 2,
                                                  //color: Colors.black,
                                                ),
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    dropdownGenderValue = newValue;
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
                                                      //style: TextStyle(color: Colors.black),
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
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                child: Form(
                                                  autovalidate: true,
                                                  onChanged: () {
                                                    Form.of(primaryFocus.context).save();
                                                  },
                                                  child: TextFormField(

                                                    keyboardType: TextInputType.number,
                                                    //initialValue: fileContent['height'],
                                                    controller: heightInputController,

                                                    decoration: const InputDecoration(

                                                      hintText: 'Ex: 180',

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
                                        showHeightErrorMessage ? Text("invalid height", style: TextStyle(color: Colors.red),) : Container(),
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
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                child: TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  //initialValue: fileContent['weight'],
                                                  decoration: const InputDecoration(

                                                    hintText: 'Ex: 70',

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
                                        showWeightErrorMessage ? Text("invalid weight", style: TextStyle(color: Colors.red),) : Container(),
                                        SizedBox(height: 5,),
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
                                                    _dateTime == null
                                                        ? InkWell(
                                                            child:
                                                                Text("Pick a date"),
                                                            onTap: () {
                                                              _showDatePicker();
                                                            },
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets.only(
                                                                left: 12.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  '${_dateTime.year}-${_dateTime.month.toString().padLeft(2, '0')}-${_dateTime.day.toString().padLeft(2, '0')}',
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
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
                              //color: Colors.black,
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
                                  value: dropdownGoalValue,
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
                                      goal = dropdownGoalValue;
                                      fileContent['goal'] = goal;
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
/*
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: DirectSelect(
                            itemExtent: 45.0,
                            selectedIndex: selectedIndex1,
                            backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white: Colors.grey,
                            child: MySelectionItem(
                              isForList: false,
                              title: elements1[selectedIndex1],
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedIndex1 = index;
                                goal = elements1[selectedIndex1];
                              });
                            },
                            items: _buildItems1()),
                      ),


 */
                      SizedBox(height: 20),

                      Column(
                        children: <Widget>[Column(
                          children: <Widget>[
                            new Padding(padding: new EdgeInsets.only(top: 10.0)),
                            /*
                            new Text("File content: ", style: new TextStyle(fontWeight: FontWeight.bold),),
                            new Text(fileContent.toString()),
                            //new Text(fileContent['goal'] != null ? fileContent['goal'] : " "),

                             */
                            new Padding(padding: new EdgeInsets.only(top: 10.0)),

                          ],
                        ),

                        ],
                      ),
                    ],
                  ),
                ),
                Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Palette.miraCalPink,
                              height: 10,
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                            Container(
                              color: Colors.grey,
                              height: 5,
                              width: MediaQuery.of(context).size.width * 0.55,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.navigate_next,
                                //color: Colors.black,
                                size: 40,
                              ),
                              onPressed: () {
                                if (validHeight && validWeight && validBirthdate) {
                                  print("All valid, go next");

                                  deleteFileContent();
                                  saveInfoToJsonFile();

                                  if (goal == "Maintain weight") {
                                    writeToFile("weightGoal", double.parse(weightInput).toString());
                                    writeToFile("weightGoalPlan", 1.toString());

                                  }

                                  print("GOAL IS: " + goal);

                                  writeToFile("gender", dropdownGenderValue);
                                  writeToFile("height", heightInput.toString());
                                  writeToFile("weight", double.parse(weightInput).toString());
                                  writeToFile("birthdate", _dateTime.toString());
                                  writeToFile("goal", dropdownGoalValue);


                                  if (fileContent['goal'] == "Maintain weight") {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Question3()),
                                    );

                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Question2()),
                                    );

                                  }

                                } else {
                                  print('invalid bitches');
                                  _showErrorDialog();
                                }









                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height:30),

                    ],
                  ),
                ),


              ],
            ),
          ),
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
      onClose: (){
        setState(() {
          print("----- onClose -----");
          if (birthDate != null) {
            validBirthdate = true;
          }

        });
      },
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
