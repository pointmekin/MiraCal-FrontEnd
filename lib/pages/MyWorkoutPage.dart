import 'package:flutter/material.dart';
import 'package:flutter_app/pages/CreateCustomFoodPage.dart';
import 'package:flutter_app/pages/CreateCustomWorkoutPage.dart';
import 'package:flutter_app/pages/WorkoutDetails.dart';
import 'package:flutter_app/pages/WorkoutDetailsFromMyWorkout.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../main.dart';
import 'FoodDetails.dart';

class MyWorkoutPage extends StatefulWidget {
  @override
  _MyWorkoutPageState createState() => _MyWorkoutPageState();
}

class _MyWorkoutPageState extends State<MyWorkoutPage> {

  bool displayThaiMenus = true;
  int nameLanguageIndex = 0;

  ///////////////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  String defaultHeight;


  ////////////////////////////

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




    }));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Palette.whiteThemeBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "My Workout",
              //style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
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
      body: fileContent == null ? Container() : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30),
              child: Container(
                width: (MediaQuery.of(context).size.width-60),
                height: 50,

                decoration: BoxDecoration(
                    color: Palette.miraCalPink.withOpacity(0.7),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: InkWell(

                    //highlightColor: Palette.whiteThemeBackgroundColor,
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CreateCustomWorkoutPage()),
                      );
                    },
                    child: Container(
                      child: Stack(
                        children: [

                          Center(

                              child: Text("Create a New Workout", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
                        ],
                      ),
                    )
                ),
              ),
            ),

            SizedBox(height:20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text("My Workouts", style: TextStyle(color: Palette.miraCalPink, fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
            ),

            SizedBox(height:20),

            fileContent['myWorkoutList'] == null || fileContent['myWorkoutList'].length == 0
                ? Text("You have not created any workout yet")
                : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: fileContent['myWorkoutList'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            String workoutName =
                            fileContent['myWorkoutList'][index][nameLanguageIndex] == "" ? fileContent['myWorkoutList'][index][1] : fileContent['myWorkoutList'][index][nameLanguageIndex];
                            String workoutCal =
                            fileContent['myWorkoutList'][index][2].toString();
                            List<String> workoutInfo = [workoutName, workoutCal];
                            print(workoutName);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutDetailsFromMyWorkout(),
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
                                        width: MediaQuery.of(context).size.width*0.60,
                                        child: Text(
                                          fileContent['myWorkoutList'][index][nameLanguageIndex] == "" ? fileContent['myWorkoutList'][index][1] : fileContent['myWorkoutList'][index][nameLanguageIndex],
                                          style: TextStyle(fontSize: 15, ),)),
                                    Container(
                                      //width: MediaQuery.of(context).size.width*0.2,
                                        child: Text(fileContent['myWorkoutList'][index][2].toString() + " Cal", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Palette.miraCalPink),)),
                                    IconButton(
                                      onPressed: (){
                                        List<dynamic> tempMyFoodList = fileContent['myWorkoutList'];
                                        tempMyFoodList.removeAt(index);

                                        setState(() {

                                          Map<String, dynamic> jsonFileContent =
                                          json.decode(jsonFile.readAsStringSync());
                                          fileContent['myWorkoutList'] = tempMyFoodList;
                                          jsonFileContent['myWorkoutList'] = fileContent['myWorkoutList'];

                                          jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this saves
                                        });

                                        Fluttertoast.showToast(
                                            msg: "Removed",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey.withOpacity(0.5),
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );





                                      },
                                      icon: Icon(Icons.delete, color: Colors.grey,),
                                    ),
                                  ],
                                ),
                                SizedBox(height:5),



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
