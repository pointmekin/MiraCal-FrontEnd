import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/info/workoutData.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/Food.dart';
import 'package:flutter_app/pages/WorkoutDetails.dart';
import 'package:flutter_app/pages/WorkoutSearch.dart';
import 'package:path_provider/path_provider.dart';
import 'FoodSearch2.dart';
import 'package:flutter_app/info/foodData.dart';
import 'package:flutter_app/pages/FoodDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WorkoutCategories extends StatefulWidget {
  @override
  _WorkoutCategoriesState createState() => _WorkoutCategoriesState();
}

class _WorkoutCategoriesState extends State<WorkoutCategories> {

  // STATES
  bool showThaiDetails = false;
  bool showAllMeals = false;
  bool showAllDrinks = false;
  bool showAllIngredients = false;
  bool showAllDesserts = false;
  bool showAllSnacks = false;

  bool showNorthernMeal = false;
  bool showSouthernMeal = false;
  bool showIsarnMeal = false;
  bool showOtherThaiMeal = false;
  bool showJapaneseMeal = false;
  bool showChineseMeal = false;
  bool showWesternMeal = false;
  bool showOtherMeal = false;

  bool showSoftDrinks = false;
  bool showCoffee = false;
  bool showTea = false;
  bool showAlcohol = false;
  bool showColdHotDrinks = false;
  bool showJuice = false;

  bool showVegetables = false;
  bool showMeat = false;
  bool showCarb = false;
  bool showDairy = false;
  bool showFruits = false;
  bool showGrains = false;

  bool showThaiDessert = false;
  bool showInternationalDessert = false;

  bool displayThaiMenus = true;
  static int nameLanguageIndex = 0;




  /////////////////////////////
  ////////////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  /////////////////////////

  @override
  void initState() {
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    }).then((value) => (){});

    super.initState();

  }


  @override
  Widget build(BuildContext context) {



    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //backgroundColor: Palette.whiteThemeBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(115.0),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: AppBar(
              title: Text(
                "Categories",
                //style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[

                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  height: 20,
                  width: MediaQuery.of(context).size.width*0.3,
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
                          Text(" Search...")
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15,),
              ],
              bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey.withOpacity(0.7),
                    indicatorColor: Palette.miraCalPink,
                    tabs: [
                      Tab(
                        child: Text('Gym Activities'),
                      ),
                      Tab(
                        child: Text('Traning & Sports'),
                      ),
                      Tab(
                        child: Text('Outdoor Activities'),
                      ),


                    ]),
                preferredSize: Size.fromHeight(200.0),
              ),



            ),
          ),

        ),
        body: fileContent == null ? Container() : TabBarView(
          children: <Widget>[

            // Gym Activities
            Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton.icon(onPressed: (){
                            setState(() {
                              displayThaiMenus = !displayThaiMenus;
                              displayThaiMenus ? nameLanguageIndex = 0 : nameLanguageIndex = 1;
                            });
                          },
                              icon: Icon(Icons.language),
                              label: displayThaiMenus ? Text("EN") : Text("ไทย")),
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: WorkoutData.gymList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: InkWell(
                              onTap: () {
                                String workoutName =
                                WorkoutData.gymList[index][_WorkoutCategoriesState.nameLanguageIndex].toString();
                                String workoutCal =(((WorkoutData.gymList[index][2] * double.parse(fileContent['weight']))+ double.parse(WorkoutData.gymList[index][3])).round().toString());
                                List<String> workoutInfo = [workoutName, workoutCal];
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
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(WorkoutData.gymList[index][nameLanguageIndex])),
                                      SizedBox(width:10),
                                      Container(child: Text((((WorkoutData.gymList[index][2] * double.parse(fileContent['weight']))+ double.parse(WorkoutData.gymList[index][3])).round().toString() + " Cal"))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton.icon(onPressed: (){
                            setState(() {
                              displayThaiMenus = !displayThaiMenus;
                              displayThaiMenus ? nameLanguageIndex = 0 : nameLanguageIndex = 1;
                            });
                          },
                              icon: Icon(Icons.language),
                              label: displayThaiMenus ? Text("EN") : Text("ไทย")),
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: WorkoutData.sportsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: InkWell(
                              onTap: () {
                                String workoutName =
                                WorkoutData.sportsList[index][_WorkoutCategoriesState.nameLanguageIndex].toString();
                                String workoutCal =(((WorkoutData.sportsList[index][2] * double.parse(fileContent['weight']))+ double.parse(WorkoutData.sportsList[index][3])).round().toString());
                                List<String> workoutInfo = [workoutName, workoutCal];
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
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(WorkoutData.sportsList[index][nameLanguageIndex])),
                                      SizedBox(width:10),
                                      Container(child: Text((((WorkoutData.sportsList[index][2] * double.parse(fileContent['weight']))+ double.parse(WorkoutData.sportsList[index][3])).round().toString() + " Cal"))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton.icon(onPressed: (){
                            setState(() {
                              displayThaiMenus = !displayThaiMenus;
                              displayThaiMenus ? nameLanguageIndex = 0 : nameLanguageIndex = 1;
                            });
                          },
                              icon: Icon(Icons.language),
                              label: displayThaiMenus ? Text("EN") : Text("ไทย")),
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: WorkoutData.outdoorList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: InkWell(
                              onTap: () {
                                String workoutName =
                                WorkoutData.outdoorList[index][_WorkoutCategoriesState.nameLanguageIndex].toString();
                                String workoutCal =(((WorkoutData.outdoorList[index][2] * double.parse(fileContent['weight']))+ double.parse(WorkoutData.outdoorList[index][3])).round().toString());
                                List<String> workoutInfo = [workoutName, workoutCal];
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
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(WorkoutData.outdoorList[index][nameLanguageIndex])),
                                      SizedBox(width:10),
                                      Container(child: Text((((WorkoutData.outdoorList[index][2] * double.parse(fileContent['weight']))+ double.parse(WorkoutData.outdoorList[index][3])).round().toString() + " Cal"))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),


          ],
        ),


      ),
    );
  }
}

class SouthernFoodList extends StatelessWidget {

  List<dynamic> southernFoodList = FoodData.mealList.where((element) => element[6] == "Southern").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: southernFoodList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    southernFoodList[index][_WorkoutCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    southernFoodList[index][2].toString();
                    List<String> foodInfo = [foodName, foodCal];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutDetails(),
                        settings: RouteSettings(
                          arguments: foodInfo,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(southernFoodList[index][_WorkoutCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(southernFoodList[index][2].toString() + " Cal")),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}

/*
class OtherThaiFoodList extends StatelessWidget {

  List<dynamic> otherThaiFoodList = FoodData.mealList.where((element) => element[6] == "other").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: otherThaiFoodList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    otherThaiFoodList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    otherThaiFoodList[index][2].toString();
                    List<String> foodInfo = [foodName, foodCal];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetails(),
                        settings: RouteSettings(
                          arguments: foodInfo,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(otherThaiFoodList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(otherThaiFoodList[index][2].toString() + " Cal")),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
*/

