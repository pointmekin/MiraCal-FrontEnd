import 'package:flutter/material.dart';
import 'package:flutter_app/info/foodData.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/pages/Wrapper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'HomeBasePage.dart';


class FoodDetails extends StatefulWidget {
  @override
  _FoodDetailsState createState() => _FoodDetailsState();

}

class _FoodDetailsState extends State<FoodDetails> {

  String calEatenDateKey;
  String newAddedCal;
  String foodEatenDateKey;
  List<List<String>> tempFoodEatenList;
  String foodEatenList;
  double servings = 1;
  String error = '';
  bool isFavoriteFood = false;
  List<dynamic> favoriteFoodList = [];
  bool show = false;

  final snackBar = SnackBar(
    content: Text("Added to today's food."),
    /*
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),

       */
  );

  // Find the Scaffold in the widget tree and use
  // it to show a SnackBar.



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

  void showSnackBar() {
    Scaffold.of(context).showSnackBar(snackBar);
  }

  bool notMyFood(String foodName) {
    bool returnBool = false;
    for (int i = 0; i < FoodData.ingredientsList.length; i++) {
      FoodData.ingredientsList[i][0] == foodName || FoodData.ingredientsList[i][1] == foodName ? returnBool = true : null;
    }
    for (int i = 0; i < FoodData.drinksList.length; i++) {
      FoodData.drinksList[i][0] == foodName  || FoodData.drinksList[i][1] == foodName? returnBool = true : null;
    }
    for (int i = 0; i < FoodData.mealList.length; i++) {
      FoodData.mealList[i][0] == foodName  || FoodData.mealList[i][1] == foodName? returnBool = true : null;
    }
    for (int i = 0; i < FoodData.snackList.length; i++) {
      FoodData.snackList[i][0] == foodName  || FoodData.snackList[i][1] == foodName? returnBool = true : null;
    }
    for (int i = 0; i < FoodData.dessertList.length; i++) {
      FoodData.dessertList[i][0] == foodName  || FoodData.dessertList[i][1] == foodName? returnBool = true : null;
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

      calEatenDateKey = "calEaten" + DateTime.now().toString().substring(0,10);
      print ("calEatenDateKey is " + calEatenDateKey);
      foodEatenDateKey = "foodEaten" + DateTime.now().toString().substring(0,10);
      print("foodEatenDateKey is "+ foodEatenDateKey);

      if (fileContent['favoriteFoodList'] == null) {
        // don't do shit
      } else {
        favoriteFoodList = fileContent['favoriteFoodList'];
        // check is this menu is in the favorite menu list
        final List<String> foodInfo = ModalRoute.of(context).settings.arguments;
        for (int i = 0; i < favoriteFoodList.length; i++) {
          if (foodInfo[0] == favoriteFoodList[i][0] || foodInfo[0] == favoriteFoodList[i][1] ){
            setState(() {
              isFavoriteFood = true;
            });
          }
        }
      }

    }));

  }

  @override
  Widget build(BuildContext context) {

    final List<String> foodInfo = ModalRoute.of(context).settings.arguments;
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
                                  width: MediaQuery.of(context).size.width* 0.65,
                                  child: Text(
                                    foodInfo[0],
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                notMyFood(foodInfo[0]) ? Container(
                                  height: 50.0,
                                  width: 60,
                                  child: Center(
                                    child: FlatButton(
                                      child: isFavoriteFood ? Icon(Icons.star, color: Palette.miraCalPink,) : Icon(Icons.star_border),
                                      onPressed: () {
                                        setState(() {
                                          isFavoriteFood = !isFavoriteFood;

                                          // if isFavoriteFood, then
                                          // check if favoritefoodlist exists in jsonfile
                                          // if it exists add this menu to that list
                                          // if it doesn't exist, create that list and add this menu to that list

                                          // if not favorite food, then
                                          // check if this menu is in the fav list in json file
                                          // if it exists, delete that
                                          // if it doesn't, dont do shit

                                          isFavoriteFood
                                              ? addFavoriteFood(foodInfo[0])
                                              : deleteFavoriteFood(foodInfo[0]);

                                          print(favoriteFoodList);

                                          Map<String, dynamic> jsonFileContent =
                                          json.decode(jsonFile.readAsStringSync());



                                          if (fileContent["favoriteFoodList"] == null) {
                                            writeToFile("favoriteFoodList", favoriteFoodList);
                                            jsonFileContent["favoriteFoodList"] = favoriteFoodList;
                                          } else {
                                            fileContent['favoriteFoodList'] = favoriteFoodList;
                                            jsonFileContent["favoriteFoodList"] = fileContent['favoriteFoodList'];

                                          }
                                          // this edits the original json data source
                                          jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this saves


                                        });



                                      },
                                    ),
                                  ),
                                )
                                    : Container(),
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
                                              (int.parse(foodInfo[1])*servings).round().toString() + " Calories",
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
                                      Text("Serving: "),
                                      Container(
                                        width: 50,
                                        child: TextFormField(
                                          initialValue: "1",
                                          textAlign: TextAlign.center,
                                          //controller: servingsController,
                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          onChanged: (value){
                                            setState(() {
                                              if (value.contains(",") || value.contains("-") || value.contains (" ")) {
                                                error = "Invalid Number";
                                              } else {
                                                error = '';
                                                servings = double.parse(value);
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



                            InkWell(
                              onTap: () {
                                _showConfirmationDialog(foodInfo);

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
                                                  "Add to today's food",
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
                        //color: Colors.white,

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

  Future<void> _showConfirmationDialog(List<String> foodInfo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Add ' + foodInfo[0] + " to today's food?"),
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
                //final List<String> foodInfo = ModalRoute.of(context).settings.arguments;

                print("cal gotten from this meal is " + (double.parse(foodInfo[1])*servings).round().toString());
                print("Add to today's food clicked");
                Map<String, dynamic> jsonFileContent =
                json.decode(jsonFile.readAsStringSync());

                if (fileContent[foodEatenDateKey] != null){
                  setState(() {


                    final regExp = new RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
                    String temp = fileContent[foodEatenDateKey];
                    final input = temp;
                    var result = regExp.allMatches(input).map((m) => m.group(1))
                        .map((String item) => item.replaceAll(new RegExp(r'[\[\],]'), ''))
                        .map((m) => [m])
                        .toList();
                    print(result);

                    List<String> toAdd = [(foodInfo[0] + " x " + servings.toString()), (double.parse(foodInfo[1])*servings).round().toString()];

                    result.add(toAdd);
                    foodEatenList = result.toString();
                  });
                  //tempFoodEatenList.add([foodInfo[0], foodInfo[1]]);
                  //foodEatenList = tempFoodEatenList.toString();
                  jsonFileContent[foodEatenDateKey] = foodEatenList;
                } else {
                  setState(() {
                    tempFoodEatenList= [[(foodInfo[0]  + " x " + servings.toString()), (double.parse(foodInfo[1])*servings).round().toString()]];
                  });
                  foodEatenList = tempFoodEatenList.toString();
                  writeToFile(foodEatenDateKey, foodEatenList);
                  jsonFileContent[foodEatenDateKey] = foodEatenList;
                }

                if(fileContent[calEatenDateKey] != null) {
                  print("if executed");
                  jsonFileContent[calEatenDateKey] = (double.parse(jsonFileContent[calEatenDateKey]) +(double.parse(foodInfo[1])*servings)).round().toString();
                } else {
                  print("else executed");
                  String newFoodCal = (double.parse(foodInfo[1])*servings).round().toString();
                  writeToFile(calEatenDateKey, "$newFoodCal");

                  //writeToFile(foodEatenDateKey, foodEatenList)
                  jsonFileContent[calEatenDateKey] = newFoodCal;

                  //jsonFileContent[calEatenDateKey] = foodInfo[1];

                }

                fileContent['lastUsed'] = DateTime.now().toString();
                jsonFileContent['lastUsed'] = fileContent['lastUsed'];

                jsonFile.writeAsStringSync(json.encode(jsonFileContent));

                Navigator.pop(context);

                dailyInfo.calEatenToday = dailyInfo.calEatenToday + int.parse((double.parse(foodInfo[1]) *servings).round().toString());

                //Navigator.of(context).pop();

                Navigator.pop(context);

                Future.delayed(const Duration(milliseconds: 1000), () {




                });



                Fluttertoast.showToast(
                    msg: "Added to Today's Food",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    textColor: Colors.white,
                    fontSize: 16.0
                );








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

  List<dynamic> getFood(String foodname,int language_index){
    for(int i = 0;i < FoodData.dessertList.length;i++){
      if(FoodData.dessertList[i][language_index].toLowerCase().contains(foodname.toLowerCase())){
        return(FoodData.dessertList[i]);
      }
    }
    for(int i = 0;i < FoodData.mealList.length;i++){
      if(FoodData.mealList[i][language_index].toLowerCase().contains(foodname.toLowerCase())){
        return(FoodData.mealList[i]);
      }
    }
    for(int i = 0;i < FoodData.drinksList.length;i++){
      if(FoodData.drinksList[i][language_index].toLowerCase().contains(foodname.toLowerCase())){
        return(FoodData.drinksList[i]);
      }
    }
    for(int i = 0;i < FoodData.ingredientsList.length;i++){
      if(FoodData.ingredientsList[i][language_index].toLowerCase().contains(foodname.toLowerCase())){
        return(FoodData.ingredientsList[i]);
      }
    }
    for(int i = 0;i < FoodData.snackList.length;i++){
      if(FoodData.snackList[i][language_index].toLowerCase().contains(foodname.toLowerCase())){
        return(FoodData.snackList[i]);
      }
    }
  }

  void addFavoriteFood(String foodname){
    bool isEnglish = alphabet.contains(foodname.toLowerCase()[0]);
    int language_index = 1;
    if (isEnglish){ language_index = 0;}
    favoriteFoodList.add(getFood(foodname,language_index));

    Fluttertoast.showToast(
        msg: "Added to Favorite Food",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void deleteFavoriteFood(String foodname){
    bool isEnglish = alphabet.contains(foodname.toLowerCase()[0]);
    int language_index = 1;
    if (isEnglish){ language_index = 0;}
    for(int i = 0;i < favoriteFoodList.length;i++){
      if(favoriteFoodList[i][language_index].toLowerCase().contains(foodname.toLowerCase())){
        favoriteFoodList.removeAt(i);
      }
    }

    Fluttertoast.showToast(
        msg: "Removed from Favorite Food",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}
