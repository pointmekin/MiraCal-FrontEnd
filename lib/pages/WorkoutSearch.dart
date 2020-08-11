//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/info/OfflineFoodSearch.dart';
import 'package:flutter_app/info/OfflineWorkoutSearch.dart';
import 'package:flutter_app/pages/FoodDetails.dart';
import 'package:flutter_app/pages/WorkoutDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

import '../main.dart';

class WorkoutSearch extends StatefulWidget {
  @override
  _WorkoutSearchState createState() => _WorkoutSearchState();
}

class _WorkoutSearchState extends State<WorkoutSearch> {
  String query = '';
  List foodData;
  bool isMore = false;
  bool allowNewFetch = true;
  int timer = 0;
  bool hasNotBeenEditedIn2Seconds = true;
  int fetchCount = 0;
  bool isMoreNotClicked = true;
  bool loadingMoreFood = false;
  List<dynamic> searchResults;
  double userWeight = 0;

  ////////////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  /////////////////////////

  void startTimer() async {
    setState(() {
      hasNotBeenEditedIn2Seconds = false;
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        hasNotBeenEditedIn2Seconds = true;
      });
    });
  }

  String clearQuery() {
    setState(() {
      query = '';
    });
    return "KUAY";
  }

  fetchFoodData(String query) async {
    print(query);
    String tempQuery = query.toLowerCase();
    if (query == null || query == '') {
    } else {
      String isMore = 'false';
      http.Response response = await http.get(
          'https://us-central1-miracalapp-e1718.cloudfunctions.net/app/GET/search/foods/$tempQuery/$isMore');
      setState(() {
        foodData = json.decode(response.body);
      });
      print("!!! completed fetching, fetch count is " +
          (fetchCount += 1).toString());
    }
    setState(() {
      clearQuery();
    });
  }

  fetchFoodDataMore(String query) async {
    setState(() {
      loadingMoreFood = true;
    });
    //String tempQuery = query.substring(0, query.indexOf(" "));
    String tempQuery = query;
    print(tempQuery);
    tempQuery = tempQuery.toLowerCase();
    if (tempQuery == null || tempQuery == '') {
    } else {
      String isMore = 'true';
      http.Response response = await http.get(
          'https://us-central1-miracalapp-e1718.cloudfunctions.net/app/GET/search/foods/$tempQuery/$isMore');
      setState(() {
        List tempFoodData = json.decode(response.body);
        for (int i = 0; i < tempFoodData.length; i++) {
          if (i == 0) {
          } else {
            foodData.add(tempFoodData[i]);
          }
        }
      });
      print("!!! completed fetching, fetch count is " +
          (fetchCount += 1).toString());
      print(foodData);
      setState(() {
        loadingMoreFood = false;
      });

    }
    setState(() {
      clearQuery();
    });
  }
  
  void setUserWeight () {
    setState(() {
      String tempUserWeight = fileContent['weight'];
      userWeight = double.parse(tempUserWeight);
      print(userWeight);
    });
  }

  @override
  void initState() {
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    }).then((value) => (){setUserWeight();});
    
    super.initState();
    print(userWeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      //backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          //color: Colors.grey.shade200,
          //height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 20,
                child: TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.miraCalPink)),

                  ),
                  onChanged: (String value) {
                    setState(() {
                      query = value;
                      searchResults = searchingExercise(query);
                    });




// This is the old food search code that retrieves info from firestore
/*
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      setState(() {
                        if (hasNotBeenEditedIn2Seconds) {
                          query == '' || query == null
                              ? null
                              : fetchFoodData(query);
                          startTimer();
                        } else {}
                      });
                    });

*/
                  },
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                    print("saved");
                  },
                  validator: (String value) {
                    return value.contains('@')
                        ? 'Do not use the @ char.'
                        : null;
                  },
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
      body: fileContent == null ? Container() : SingleChildScrollView(
        child: Column(
          children: [
            fileContent == null ? Container() : buildSuggestions(context),
            SizedBox(
              height: 20,
            ),
            /*
            InkWell(
              child: Text(
                "Show more",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                print("Request for more search results from database");
              },
            ),
             */
          ],
        ),
      ),
    );
  }

  Widget buildSuggestions (BuildContext context) {

    var suggestionList = query.isEmpty && searchResults == null || fileContent['myWorkoutList'] == null

        ? []
        : fileContent['myWorkoutList']
        .where((element) => element[0]
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();

    return searchResults == null
        ? query == '' ? Container() : Center(
      child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Container(),
      )//CircularProgressIndicator()),
    )
        : SingleChildScrollView(
      child: Column(
        children: [

          SizedBox(height: 5,),

          suggestionList.length == 0
              ? Container()
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal:30),
            child: Row(
              children: [
                Text("My Workout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Palette.miraCalPink)),
              ],
            ),
          ),

          suggestionList.length == 0
              ? Container()
              :ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: suggestionList.length,
              itemBuilder: (context,index){
//Text(suggestionList[index][0])


                return Column(
                  children: [
                    InkWell(
                      onTap: (){
                        String workoutName =
                        suggestionList[index][0].toString();
                        String workoutCal =
                        suggestionList[index][1].round().toString();
                        List<String> foodInfo = [workoutName, workoutCal];
                        print(workoutName);
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
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.65,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          suggestionList[index][0] != null
                                              ? Text(
                                            suggestionList[index][0]
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                              : Text(""),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              "Energy: " +
                                                  suggestionList[index]
                                                  [2].toString() == null
                                                  ? ""
                                                  : suggestionList[index][2].toString() + " Cal",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFE39090)),
                                            ),

                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          )
                      ),
                    ),
                    Divider(),
                  ],
                );
              }
          ),
          SizedBox(height: 10,),

          searchResults.length == 0 ? Container() :

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Text("MiraCal Workout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Palette.miraCalPink),),
              ],
            ),
          ),
          SizedBox(height: 5,),




          searchResults.length == 0 ? Container() : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: (){
                        String foodName =
                        searchResults[index][0].toString();
                        String foodCal =
                        (((searchResults[index][1] * double.parse(fileContent['weight']))+ double.parse(searchResults[index][2])).round().toString());
                        List<String> foodInfo = [foodName, foodCal];
                        print(foodName);
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
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        searchResults[index][0] != null
                                            ? Text(
                                          searchResults[index][0]
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "Energy: " +
                                                searchResults[index]
                                                [1].toString() == null
                                                ? ""
                                                : (((searchResults[index][1] * double.parse(fileContent['weight']))+ double.parse(searchResults[index][2])).round().toString() + " Cal"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFE39090)),
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(searchResults[index][3].substring(0,1).toString().toUpperCase() + searchResults[index][3].substring(1),
                                    style: TextStyle(color: Colors.grey),),
                                ],
                              ),
                            )
                          ],
                        )
                      ),
                    ),
                    Divider(),
                  ],
                );

              })
        ],
      ),

    );
  }
// This is the old search results from searching online through firebase firestore
/*
  Widget buildSuggestions1(BuildContext context) {
    // TODO: implement buildSuggestions

    var suggestionList = query.isEmpty && searchResults == null
        ? searchResults
        : searchResults == null
            ? searchResults
            : searchResults
                .where((element) => element[0]
                    .toString()
                    .toLowerCase()
                    .startsWith(query.toLowerCase()))
                .toList();

    return suggestionList == null || suggestionList.length == 0
        ? query == '' ? Container() : Center(
            child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator()),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: suggestionList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            String foodName =
                                suggestionList[index][0].toString();
                            String foodCal =
                                suggestionList[index][1].toString();
                            List<String> foodInfo = [foodName, foodCal];
                            print(foodName);
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
                                children: <Widget>[
                                  Container(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        suggestionList[index][0] != null
                                            ? Text(
                                                suggestionList[index][0]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : Text(""),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "Energy: " +
                                                        suggestionList[index]
                                                            [1].toString() ==
                                                    null
                                                ? ""
                                                : suggestionList[index][1]
                                                        .toString() +
                                                    " Cal",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFE39090)),
                                          ),
                                          /*
                                      Text(
                                        "ACTIVE: " +
                                            suggestionList[index]['active'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      Text(
                                        "RECOVERED: " +
                                            suggestionList[index]['recovered']
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                      Text(
                                        "DEATHS: " +
                                            suggestionList[index]['deaths'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),

                                       */
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 15,
                ),
                loadingMoreFood
                    ? Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 20, width:20, child: CircularProgressIndicator()),
                          SizedBox(width:5),
                          Text("loading...")
                        ],
                      ),
                    )
                    : InkWell(
                  onTap: () {
                    isMoreNotClicked = false;
                    fetchFoodDataMore(
                        suggestionList[suggestionList.length - 1][0]);
                  },
                  child: Column(
                    children: [
                      Text('Get more results'),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
*/
}

