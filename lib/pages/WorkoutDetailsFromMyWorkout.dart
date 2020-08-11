import 'package:flutter/material.dart';
import 'package:flutter_app/info/workoutData.dart';
import 'package:flutter_app/models/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'HomeBasePage.dart';

class WorkoutDetailsFromMyWorkout extends StatefulWidget {
  @override
  _WorkoutDetailsFromMyWorkoutState createState() => _WorkoutDetailsFromMyWorkoutState();

}

class _WorkoutDetailsFromMyWorkoutState extends State<WorkoutDetailsFromMyWorkout> {

  String calWorkoutDateKey;
  String newAddedCal;
  String foodEatenDateKey;
  List<List<String>> tempCalWorkoutList;
  String workoutList;
  double duration;
  double originalDuration;
  String error = '';
  //String calWorkoutDateKey;
  String workoutListDateKey;
  bool isFavoriteWorkout = false;
  List<dynamic> favoriteWorkoutList = [];
  List<String> workoutInfo;


  TextEditingController servingsController = new TextEditingController();
  ///////////////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  String defaultHeight;

  ////////////////////////////




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
  }

  bool notMyWorkout(String workoutName) {
    bool returnBool = false;
    for (int i = 0; i < WorkoutData.gymList.length; i++) {
      WorkoutData.gymList[i][0] == workoutName || WorkoutData.gymList[i][1] == workoutName ? returnBool = true : null;
    }
    for (int i = 0; i < WorkoutData.sportsList.length; i++) {
      WorkoutData.sportsList[i][0] == workoutName  || WorkoutData.sportsList[i][1] == workoutName? returnBool = true : null;
    }
    for (int i = 0; i < WorkoutData.outdoorList.length; i++) {
      WorkoutData.outdoorList[i][0] == workoutName  || WorkoutData.outdoorList[i][1] == workoutName? returnBool = true : null;
    }

    return returnBool;

  }

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    }).then((value) => setState(() {



      calWorkoutDateKey = "calWorkout" + DateTime.now().toString().substring(0,10);
      print("calWorkoutDateKey is "+ calWorkoutDateKey);
      workoutListDateKey = "workoutList" + DateTime.now().toString().substring(0,10);
      print("workoutListDateKey is "+ workoutListDateKey);

      if (fileContent['favoriteWorkoutList'] == null) {
        // don't do shit
      } else {
        favoriteWorkoutList = fileContent['favoriteWorkoutList'];
        // check is this menu is in the favorite menu list
        final List<String> workoutInfo = ModalRoute.of(context).settings.arguments;
        for (int i = 0; i < favoriteWorkoutList.length; i++) {
          if (workoutInfo[0] == favoriteWorkoutList[i][0] || workoutInfo[0] == favoriteWorkoutList[i][1] ){
            setState(() {
              isFavoriteWorkout = true;
            });
          }
        }
      }

    }));

  }

  @override
  Widget build(BuildContext context) {
    final List<String> workoutInfo = ModalRoute.of(context).settings.arguments;

    if (duration == null && originalDuration == null ) {
      setState(() {

        duration = double.parse(workoutInfo[0].substring(workoutInfo[0].lastIndexOf("x") +2,workoutInfo[0].lastIndexOf(" mins")));
        originalDuration = double.parse(workoutInfo[0].substring(workoutInfo[0].lastIndexOf("x") +2,workoutInfo[0].lastIndexOf(" mins")));
      });
    }



    return Scaffold(
      body: SingleChildScrollView(
        //height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[

                  new Positioned(
                    //left: 20,
                    //right:20,

                    child: Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          print('Profile pic Clicked');
                        },
                        splashColor: Colors.white12,
                        focusColor: Colors.white30,
                        child: Container(
                          decoration: BoxDecoration(
                            //color: Colors.grey.shade200,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                //borderRadius: BorderRadius.all(Radius.circular(25)),
                                              ),
                                              child: Image(
                                                image: AssetImage('lib/assets/MiraCal_logo.png'),
                                                fit: BoxFit.cover,
                                              )),
                                        ],
                                      ),
                                    ),

                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Positioned(
                    top: 270,
                    child: InkWell(
                      onTap: () {
                        print('Food pic Clicked');
                      },
                      splashColor: Colors.white12,
                      focusColor: Colors.white30,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Theme.of(context).brightness == Brightness.light ? Colors.white: Colors.black,
                          boxShadow: [
/*
                            BoxShadow(
                              color: Colors.white24,
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
                        padding: EdgeInsets.fromLTRB(30, 15, 30, 10),
                        //height: 380,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: Text(
                                    workoutInfo[0],
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                notMyWorkout(workoutInfo[0]) ? Container(
                                  height: 50.0,
                                  width: 60,
                                  child: Center(
                                    child: FlatButton(
                                      child: isFavoriteWorkout ? Icon(Icons.star, color: Palette.miraCalPink,) : Icon(Icons.star_border),
                                      onPressed: () {
                                        setState(() {
                                          isFavoriteWorkout = !isFavoriteWorkout;

                                          // if isFavoriteFood, then
                                          // check if favoriteWorkoutList exists in jsonfile
                                          // if it exists add this menu to that list
                                          // if it doesn't exist, create that list and add this menu to that list

                                          // if not favorite food, then
                                          // check if this menu is in the fav list in json file
                                          // if it exists, delete that
                                          // if it doesn't, dont do shit

                                          isFavoriteWorkout
                                              ? addFavoriteExercise(workoutInfo[0])
                                              : deleteFavoriteExercise(workoutInfo[0]);

                                          print(favoriteWorkoutList);

                                          Map<String, dynamic> jsonFileContent =
                                          json.decode(jsonFile.readAsStringSync());



                                          if (fileContent["favoriteWorkoutList"] == null) {
                                            writeToFile("favoriteWorkoutList", favoriteWorkoutList);
                                            jsonFileContent["favoriteWorkoutList"] = favoriteWorkoutList;
                                          } else {
                                            fileContent['favoriteWorkoutList'] = favoriteWorkoutList;
                                            jsonFileContent["favoriteWorkoutList"] = fileContent['favoriteWorkoutList'];

                                          }
                                          // this edits the original json data source
                                          jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this saves


                                        });



                                      },
                                    ),
                                  ),
                                ) : Container(),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height:15),

                                      //SizedBox(height: 15),
                                      Container(
                                        //width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              ((double.parse(workoutInfo[1])+ 0.0) * duration / originalDuration).round().toString() + " Calories",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            //////////////////////////////////////////
                                            // Incase you want to report naja
                                            /*
                                            FlatButton.icon(
                                              icon: Icon(Icons.edit), //`Icon` to display
                                              label:
                                              Text('Report'), //`Text` to display
                                              onPressed: () {
                                                //Code to execute when Floating Action Button is clicked
                                                print("Suggest Edit clicked");
                                              },
                                            ),

                                             */

                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),


                                    ],
                                  ),
                                ),
                                Form(

                                  child: Row(
                                    children: [
                                      Text("Duration (min): "),
                                      Container(
                                        width: 50,
                                        child: TextFormField(
                                          initialValue: duration.toString(),
                                          textAlign: TextAlign.center,
                                          //controller: servingsController,
                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          onChanged: (value){
                                            setState(() {
                                              if (value.contains(",") || value.contains("-") || value.contains (" ")) {
                                                error = "Invalid Number";
                                              } else {
                                                setState(() {
                                                  error = '';
                                                  duration = double.parse(value);
                                                });

                                              }
                                            });
                                          },

                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(error, style: TextStyle(color: Colors.red),),
                              ],
                            ),
                            Divider(color: Colors.grey),

                            SizedBox(
                              height: 25,
                            ),
                            /*
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                            SizedBox(height: 15),
                            Text(
                              "(Coming soon)",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ingredients",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),



                            SizedBox(height: 15),
                            Text(
                              "(Coming soon)",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Instructions",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                            SizedBox(height: 15),
                            Text(
                              "(ComingSoon)\n\n\n\n\n\n\n\n",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),

                             */
                            SizedBox(height: 15),
/*
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  children: [
                                    // old servings
                                    Text("Servings"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            child: Icon(Icons.remove),
                                          ),
                                          onTap: (){setState(() {
                                            servings -= 0.5;
                                          });},
                                        ),
                                        SizedBox(width: 10,),
                                        Text(servings.toString()),
                                        SizedBox(width: 10,),
                                        InkWell(
                                          child: Container(
                                            child: Icon(Icons.add),
                                          ),
                                          onTap: (){setState(() {
                                            servings += 0.5;
                                          });},
                                        ),
                                      ],
                                    ),
                                    // new servings
                                    Form(

                                      child: Row(
                                        children: [
                                          Text("Serving: "),
                                          Container(
                                            width: 50,
                                            child: TextFormField(
                                              initialValue: "1",
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.numberWithOptions(),

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),

                              ),
                            ),

 */


                            InkWell(
                              onTap: () {
                                _showConfirmationDialog(workoutInfo);

                              },
                              splashColor: Colors.white12,
                              focusColor: Colors.white30,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Color(0xFFE39090),
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
                                width: MediaQuery.of(context).size.width - 60,
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
                                                  Icons.add,
                                                  color: Colors.grey.shade200,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Add to today's workout",
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

                          ],
                        ),
                      ),
                    ),
                  ),
                  new Positioned(
                    top: 35,
                    left: 10,
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        //color: Theme.of(context).brightness == Brightness.light ? Colors.white: Colors.black,

                      ),
                      child: IconButton(

                        icon: Icon(Icons.arrow_back),
                        color: Color(0xFFE39090),
                        onPressed: (){
                          Navigator.pop(context);

                        },

                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(List<String> workoutInfo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Add ' + workoutInfo[0].substring(0, workoutInfo[0].indexOf(" x ")) + " to today's workout?"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Okay'),



              onPressed: () {
                //final List<String> workoutInfo = ModalRoute.of(context).settings.arguments;

                print("cal burnt from this workout is " + (double.parse(workoutInfo[1])*duration/originalDuration).round().toString());
                print("Add to today's workout clicked");
                Map<String, dynamic> jsonFileContent =
                json.decode(jsonFile.readAsStringSync());

                if (fileContent[workoutListDateKey] != null){
                  setState(() {


                    final regExp = new RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
                    String temp = fileContent[workoutListDateKey];
                    final input = temp;
                    var result = regExp.allMatches(input).map((m) => m.group(1))
                        .map((String item) => item.replaceAll(new RegExp(r'[\[\],]'), ''))
                        .map((m) => [m])
                        .toList();
                    print(result);


                    List<String> toAdd = [(workoutInfo[0].substring(0,workoutInfo[0].indexOf(" x ")) + " x " +duration.toString() + " min"), (double.parse(workoutInfo[1])*duration/originalDuration).round().toString()];

                    result.add(toAdd);
                    workoutList = result.toString();
                  });
                  //tempCalWorkoutList.add([workoutInfo[0], workoutInfo[1]]);
                  //workoutList = tempCalWorkoutList.toString();
                  jsonFileContent[workoutListDateKey] = workoutList;
                } else {
                  setState(() {
                    tempCalWorkoutList= [[(workoutInfo[0].substring(0,workoutInfo[0].indexOf(" x ")) + " x " +duration.toString() + " min"), (double.parse(workoutInfo[1])*duration/originalDuration).round().toString()]];
                  });
                  workoutList = tempCalWorkoutList.toString();
                  writeToFile(workoutListDateKey, workoutList);
                  jsonFileContent[workoutListDateKey] = workoutList;
                }

                if(fileContent[calWorkoutDateKey] != null) {
                  print("if executed");
                  jsonFileContent[calWorkoutDateKey] = (double.parse(jsonFileContent[calWorkoutDateKey]) +(double.parse(workoutInfo[1])*duration/originalDuration)).round().toString();
                } else {
                  print("else executed");
                  String newWorkoutCal = (double.parse(workoutInfo[1])*duration/originalDuration).round().toString();
                  writeToFile(calWorkoutDateKey, "$newWorkoutCal");

                  //writeToFile(calWorkoutDateKey, workoutList)
                  jsonFileContent[calWorkoutDateKey] = newWorkoutCal;

                  //jsonFileContent[calWorkoutDateKey] = workoutInfo[1];

                }


                //Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());

                fileContent['lastUsed'] = DateTime.now().toString();
                jsonFileContent['lastUsed'] = fileContent['lastUsed'];



                jsonFile.writeAsStringSync(json.encode(jsonFileContent));

                dailyInfo.calBurnedToday += (double.parse(workoutInfo[1])*duration/originalDuration).round();


                Navigator.pop(context);

                Fluttertoast.showToast(
                    msg: "Added to Today's Workout",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    textColor: Colors.white,
                    fontSize: 16.0
                );

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<dynamic> alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
  void bubbleSort(List<dynamic> list){
    for (int i = 0; i < list.length; i++){
      for (int j = 0; j < list.length - 1; j++){
        if (list[j][list[j].length-1] < list[j + 1][list[j+1].length-1]){
          List<dynamic> tem = list[j];
          list[j] = list[j + 1];
          list[j + 1] = tem;
        }
      }
    }
  }


  List<dynamic> getExercise(String exercisename,int language_index){
    for(int i = 0;i < WorkoutData.gymList.length;i++){
      if(WorkoutData.gymList[i][language_index].toLowerCase().contains(exercisename.toLowerCase())){
        return(WorkoutData.gymList[i]);
      }
    }
    for(int i = 0;i < WorkoutData.outdoorList.length;i++){
      if(WorkoutData.outdoorList[i][language_index].toLowerCase().contains(exercisename.toLowerCase())){
        return(WorkoutData.outdoorList[i]);
      }
    }
    for(int i = 0;i < WorkoutData.sportsList.length;i++){
      if(WorkoutData.sportsList[i][language_index].toLowerCase().contains(exercisename.toLowerCase())){
        return(WorkoutData.sportsList[i]);
      }
    }
  }

  void addFavoriteExercise(String exercisename){
    bool isEnglish = alphabet.contains(exercisename.toLowerCase()[0]);
    int language_index = 1;
    if (isEnglish){ language_index = 0;}
    favoriteWorkoutList.add(getExercise(exercisename,language_index));

    Fluttertoast.showToast(
        msg: "Added to Favorite Workout",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0
    );

  }


  void deleteFavoriteExercise(String exercisename){
    bool isEnglish = alphabet.contains(exercisename.toLowerCase()[0]);
    int language_index = 1;
    if (isEnglish){ language_index = 0;}
    for(int i = 0;i < favoriteWorkoutList.length;i++){
      if(favoriteWorkoutList[i][language_index].toLowerCase().contains(exercisename.toLowerCase())){
        favoriteWorkoutList.removeAt(i);
      }
    }

    Fluttertoast.showToast(
        msg: "Removed from Favorite Workout",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0
    );

  }

}
