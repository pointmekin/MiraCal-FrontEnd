import 'package:flutter/material.dart';
import 'package:flutter_app/pages/WorkoutDetails.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import '../main.dart';

class FavoriteWorkoutPage extends StatefulWidget {
  @override
  _FavoriteWorkoutPageState createState() => _FavoriteWorkoutPageState();
}

class _FavoriteWorkoutPageState extends State<FavoriteWorkoutPage> {

  ///////////////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  String defaultHeight;

  ////////////////////////////

  bool displayThaiMenus = true;
  int nameLanguageIndex = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
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
    });
  }


  @override
  Widget build(BuildContext context) {
    return fileContent == null ? Container() : Scaffold(
      //backgroundColor: Palette.whiteThemeBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "Favorite Workout",
              //style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              FlatButton.icon(onPressed: (){
                setState(() {
                  displayThaiMenus = !displayThaiMenus;
                  displayThaiMenus ? nameLanguageIndex = 0 : nameLanguageIndex = 1;
                });
              },
                  icon: Icon(Icons.language),
                  label: displayThaiMenus ? Text("EN") : Text("ไทย")),
            ],
            // this is the search bar
            /*
            actions: <Widget>[

              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                height: 20,
                width: MediaQuery.of(context).size.width*0.65,
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodSearch2()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),

                    height: 10,
                    width: 100,
                    child: Row(

                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.search),
                        Text(" Search food")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15,),
            ],

             */
          ),

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [



            SizedBox(height:10),

            fileContent['favoriteWorkoutList'] == null || fileContent['favoriteWorkoutList'].length == 0
                ? Center(child: Text("You have not added any Favorite Workouts"))
                : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: fileContent['favoriteWorkoutList'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            String workoutName =
                            fileContent['favoriteWorkoutList'][index][nameLanguageIndex];
                            String workoutCal =
                            (fileContent['favoriteWorkoutList'][index][2] *double.parse(fileContent['weight']) + double.parse(fileContent['favoriteWorkoutList'][index][3])).round().toString();
                            List<String> workoutInfo = [workoutName, workoutCal];
                            print(workoutName);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutDetails(),
                                settings: RouteSettings(
                                  arguments: workoutInfo,
                                ),
                              ),
                            );
                          },
                          child: Container(

                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width*0.65,
                                        child: Text(fileContent['favoriteWorkoutList'][index][nameLanguageIndex], style: TextStyle(fontSize: 15, ),)),
                                    Container(
                                      //width: MediaQuery.of(context).size.width*0.2,
                                        child: Text((fileContent['favoriteWorkoutList'][index][2] *double.parse(fileContent['weight']) + double.parse(fileContent['favoriteWorkoutList'][index][3])).round().toString() + " Cal", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Palette.miraCalPink),)),

                                  ],
                                ),
                                SizedBox(height:5),
                                Row(
                                  children: [
                                    Text(fileContent['favoriteWorkoutList'][index][5], style: TextStyle(fontSize: 15, color: Colors.grey),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );

                }
            ),
          ],
        ),
      ),
    );
  }
}
