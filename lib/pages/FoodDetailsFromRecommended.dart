import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'HomeBasePage.dart';

class FoodDetailsFromRecommended extends StatefulWidget {
  @override
  _FoodDetailsFromRecommendedState createState() => _FoodDetailsFromRecommendedState();

}

class _FoodDetailsFromRecommendedState extends State<FoodDetailsFromRecommended> {

  String calEatenDateKey;
  String newAddedCal;
  String foodEatenDateKey;
  List<List<String>> tempFoodEatenList;
  String foodEatenList;
  double servings = 1;
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
    }));

  }

  @override
  Widget build(BuildContext context) {
    final List<String> foodInfo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                            color: Colors.grey.shade200,
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
                          color: Colors.grey.shade200,
                          boxShadow: [

                            BoxShadow(
                              color: Colors.white24,
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset: Offset(
                                -5.0, // Move to right 10  horizontally
                                -5.0, // Move to bottom 10 Vertically
                              ),
                            )
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
                            Text(
                              foodInfo[0],
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
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
                                      SizedBox(height:5),

                                      //SizedBox(height: 15),
                                      Container(
                                        width: MediaQuery.of(context).size.width - 60,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              foodInfo[1] + " Calories",
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

                              ],
                            ),

                            SizedBox(
                              height: 10,
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
                            SizedBox(height: 65),

                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  children: [
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
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 50,),

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
                        color: Colors.white,

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

                print("cal gotten from this meal is " + (double.parse(foodInfo[1])*servings).toString());
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

                    List<String> toAdd = [(foodInfo[0] + " x" + servings.toString()), (double.parse(foodInfo[1])*servings).toString()];

                    result.add(toAdd);
                    foodEatenList = result.toString();
                  });
                  //tempFoodEatenList.add([foodInfo[0], foodInfo[1]]);
                  //foodEatenList = tempFoodEatenList.toString();
                  jsonFileContent[foodEatenDateKey] = foodEatenList;
                } else {
                  setState(() {
                    tempFoodEatenList= [[(foodInfo[0]  + " x" + servings.toString()), (double.parse(foodInfo[1])*servings).toString()]];
                  });
                  foodEatenList = tempFoodEatenList.toString();
                  writeToFile(foodEatenDateKey, foodEatenList);
                  jsonFileContent[foodEatenDateKey] = foodEatenList;
                }

                if(fileContent[calEatenDateKey] != null) {
                  print("if executed");
                  jsonFileContent[calEatenDateKey] = (double.parse(jsonFileContent[calEatenDateKey]) +(double.parse(foodInfo[1])*servings)).toString();
                } else {
                  print("else executed");
                  String newFoodCal = (double.parse(foodInfo[1])*servings).toString();
                  writeToFile(calEatenDateKey, "$newFoodCal");

                  //writeToFile(foodEatenDateKey, foodEatenList)
                  jsonFileContent[calEatenDateKey] = newFoodCal;

                  //jsonFileContent[calEatenDateKey] = foodInfo[1];

                }
                jsonFile.writeAsStringSync(json.encode(jsonFileContent));

                Navigator.pop(context);


                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeBasePage()),
                );





                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
