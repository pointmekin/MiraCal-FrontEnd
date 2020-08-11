import 'package:flutter/material.dart';
import 'package:flutter_app/pages/HomeBasePage.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class UpdateWeightPage extends StatefulWidget {
  @override
  _UpdateWeightPageState createState() => _UpdateWeightPageState();
}

const String MIN_DATETIME = '1990-01-11';
const String MAX_DATETIME = '2030-11-25';
const String INIT_DATETIME = '2030-05-17';

class _UpdateWeightPageState extends State<UpdateWeightPage> {
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
      print ("dateKey is " + dateKey);
    }));


  }

  @override
  void dispose() {
    keyInputController.dispose();
    valueInputController.dispose();
    super.dispose();
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
              "Update Weight",
              //style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
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
                                            width: MediaQuery.of(context).size.width - 100,


                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Current Weight",
                                                    style: TextStyle(
                                                        //color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20),
                                                  ),
                                                  Text(fileContent['weight'] + " kg", style: TextStyle(
                                                      //color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 20),),
                                                ],
                                              ),
                                            ),
                                          ),

                                        ]),
                                    SizedBox(
                                      height: 5,
                                    ),

                                    /*
                                    Divider(color: Colors.grey),
                                    SizedBox(
                                      height: 10,
                                    ),

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
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 22),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 12.0),
                                                  child: Row(
                                                    children: [
                                                      Text(fileContent[
                                                              'birthdate']
                                                          .substring(0, 10)),
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
                                                        child: Text(
                                                          "edit",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
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

                                     */

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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                      Text("New Weight"),
                    ],),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fileContent != null ? newWeight : '',
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(width: 5,),
                      Text('kg',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(color: Colors.grey),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 40,
                        onPressed: (){
                          print("subtract 0.1 from weight");
                          setState(() {
                            double temp = ((double.parse(newWeight))*100.round())/100 - 0.1;
                            newWeight = temp.toStringAsFixed(1);
                          });
                        },
                      ),
                      Text("- / + 0.1", style: TextStyle(fontSize: 20)),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 40,
                        onPressed: (){
                          print("subtract 0.1 from weight");
                          setState(() {
                            double temp = ((double.parse(newWeight))*100.round())/100 + 0.1;
                            newWeight = temp.toStringAsFixed(1);
                          });
                        },
                      ),
                    ],),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 40,
                        onPressed: (){
                          setState(() {
                            double temp = ((double.parse(newWeight))*100.round())/100 - 1;
                            newWeight = temp.toStringAsFixed(1);
                          });
                        },
                      ),
                      Text("- / + 1", style: TextStyle(fontSize: 20)),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 40,
                        onPressed: (){
                          setState(() {
                            double temp = ((double.parse(newWeight))*100.round())/100 + 1;
                            newWeight = temp.toStringAsFixed(1);
                          });
                        },
                      ),
                    ],),
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
                            //size: 20,
                          ),
                          label: Text("Save"),
                          onPressed: () {
                            //deleteFileContent();
                            //saveInfoToJsonFile();

                            Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());

                            // update the "LastUsed" variable
                            fileContent['lastUsed'] = DateTime.now().toString();
                            jsonFileContent['lastUsed'] = fileContent['lastUsed'];

                            jsonFileContent['weight'] = newWeight;
                            jsonFileContent['birthdate'] = fileContent['birthdate'];

                            // Check if today's weight has been recorded
                            // If today's weight has NOT been recorded, create it and save it
                            // If it has already been recorded, update it
                            if(fileContent[dateKey] != null) {

                              jsonFileContent[dateKey] = newWeight;
                            } else {
                              writeToFile(dateKey, newWeight);
                              jsonFileContent[dateKey] = newWeight;

                            }

                            // this edits the original json data source
                            jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this saves the json
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeBasePage()),
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

  void saveInfoToJsonFile() {
    writeToFile("test", "test");
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        backgroundColor: Colors.grey.shade200,
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
