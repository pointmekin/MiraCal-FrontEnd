import 'package:flutter/material.dart';
import 'package:flutter_app/components/FavoriteWorkoutCard.dart';
import 'package:flutter_app/components/MyWorkoutCard.dart';
import 'package:flutter_app/components/WorkoutItemCard.dart';
import 'package:flutter_app/components/workoutCalCard.dart';
import 'package:flutter_app/pages/WorkoutFilter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import '../main.dart';
import 'FoodSearch2.dart';
import 'WorkoutCategories.dart';
import 'WorkoutSearch.dart';

class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {

  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;


  String userName = "Point";
  double cardWidth;
  var whiteThemeColor = Colors.grey.shade200;
  var darkThemeColor = Colors.black;

  TextEditingController searchController = new TextEditingController();
  ScrollController _controller = new ScrollController();

  String dropdownValue = '5 min';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted)
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
              "Workout",
              //style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[

              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                height: 20,
                width: MediaQuery.of(context).size.width*0.55,
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkoutSearch()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300.withOpacity(0.5),
                    ),

                    height: 10,
                    width: 100,
                    child: Row(

                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.search),
                        Text(" Search workout")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15,),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(

          children: [



            SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text("Today", style: TextStyle(color: Color(0xFFE39090),fontSize: 22, fontWeight: FontWeight.bold),),
                ],
              ),
            ),

            /*
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
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
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(

                          hintText: "search food ...",
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        /*
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            )
                        ));

                         */
                      },
                      child: Container(child: Icon(Icons.search))),
                ],
              ),
            ),

             */


            SizedBox(height: 10,),

            WorkoutCalCard(),

            SizedBox(height:40),
            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  //Icon(Icons.fastfood, color: Palette.miraCalPink,),

                  Text("My Selection", style: TextStyle(color: Color(0xFFE39090),fontSize: 22, fontWeight: FontWeight.bold),),

                ],
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FavoriteWorkoutCard(),
                  MyWorkoutCard(),
                ],
              ),
            ),
            SizedBox(height:40),

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  //Icon(Icons.fastfood, color: Palette.miraCalPink,),
                  Text("Explore Our Workouts", style: TextStyle(color: Color(0xFFE39090),fontSize: 22, fontWeight: FontWeight.bold),),

                ],
              ),
            ),

            SizedBox(height:15),



            InkWell(
              onTap: () {
                print('Filter Food Clicked');

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutCategories()),
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
                                    Icons.track_changes,
                                    //color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Text(
                                    "Categories",
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
              height: 15,
            ),
/*
            InkWell(
              onTap: () {
                print('Find Workout Recommendations Clicked');
                // to be addded in the future
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutFilter()),
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
                                    Icons.directions_run,
                                    //color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Workout Recommendations (Coming soon)",
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
*/
            SizedBox(height:20),
            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  //Icon(Icons.directions_run, color: Palette.miraCalPink,),
                  SizedBox(width: 5,),
                  Text("MiraCal Recommends", style: TextStyle(color: Color(0xFFE39090),fontSize: 22, fontWeight: FontWeight.bold),),

                ],
              ),
            ),
            SizedBox(height:30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  WorkoutItemCard(nameEn: "Weight Lifting: general", cal: (1.544117647 *  double.parse(fileContent['weight']) + 3.448529412).round().toString(),),
                  WorkoutItemCard(nameEn: "Circuit Training: general", cal: (4.191176471 *  double.parse(fileContent['weight']) + 3.360294118).round().toString(),),
                  WorkoutItemCard(nameEn: "Running: 8 km/hr", cal: (4.191176471 *  double.parse(fileContent['weight']) + 3.360294118).round().toString(),),
                  WorkoutItemCard(nameEn: "Walking: 6.44 km/hr", cal: (2.426470588 *  double.parse(fileContent['weight']) + -3.580882353).round().toString(),),
                  WorkoutItemCard(nameEn: "Gardening: general", cal: (2.426470588 *  double.parse(fileContent['weight']) + -3.580882353).round().toString(),),

                ],
              ),
            ),



            // these are the old workout item cards
            /*
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 280,
                    child: WorkoutItemCard(),
                  );
                },
              ),
            ),

             */


          ],

        ),
      ),
      //bottomNavigationBar: NavBar(),
    );
  }
}


