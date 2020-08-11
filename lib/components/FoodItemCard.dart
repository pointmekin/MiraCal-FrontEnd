import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/FoodDetails.dart';
import 'package:flutter_app/pages/FoodDetailsFromRecommended.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FoodItemCard extends StatefulWidget {
  final String nameEn;
  final String cal;



  FoodItemCard({Key key, @required this.nameEn, this.cal}) : super(key: key);

  @override
  _FoodItemCardState createState() => _FoodItemCardState(nameEn, cal);
}

class _FoodItemCardState extends State<FoodItemCard> {
  String calEatenDateKey;
  String newAddedCal;
  String foodEatenDateKey;
  List<List<String>> tempFoodEatenList;
  String foodEatenList;
  final String nameEn;
  final String cal;
  _FoodItemCardState(this.nameEn, this.cal);
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
      //print ("calEatenDateKey is " + calEatenDateKey);
      foodEatenDateKey = "foodEaten" + DateTime.now().toString().substring(0,10);
      //print("foodEatenDateKey is "+ foodEatenDateKey);
    }));

  }

  @override
  Widget build(BuildContext context) {

    return fileContent == null ? Container() : Container(
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //////////////////////////////
          // This is where the image goes
          /*
          InkWell(
            onTap: () {
              print('Food item card Clicked');
              String foodName = nameEn;
              String foodCal = cal;
              List<String> foodInfo = [foodName, foodCal];


              Navigator.push(
                context,

                MaterialPageRoute(builder: (context) => FoodDetailsFromRecommended(), settings: RouteSettings(
                  arguments: foodInfo,
                ),),
              );
            },
            splashColor: Colors.white12,
            focusColor: Colors.white30,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.grey.shade200,
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
              //padding: EdgeInsets.fromLTRB(20, 15, 25, 10),
              height: 200,
              width: 380,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Container(
                child: (
                    Image(
                      image: AssetImage('lib/assets/MiraCal_logo.png'),
                    )
                ),
              ),
            ),
          ),

          SizedBox(height: 5,),

           */
          InkWell(
            onTap: (){
              print('Food item card Clicked');
              String foodName = nameEn;
              String foodCal = cal;
              List<String> foodInfo = [foodName, foodCal];


              Navigator.push(
                context,

                MaterialPageRoute(builder: (context) => FoodDetails(), settings: RouteSettings(
                  arguments: foodInfo,
                ),),
              );
            },
            child: Container(
              //width: MediaQuery.of(context).size.width - 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width:50,
                    height:50,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('lib/assets/MiraCal_logo.png'),
                    ),
                  ),
                  SizedBox(width: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width* 0.6,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(

                            child: Text(nameEn, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), )),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text(cal + " Cal", style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                        SizedBox(height:10),



                      ],
                    ),
                  ),
                  // this is the add button
                  /*
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 35,
                          width: 2,
                          color: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {

                            _showConfirmationDialog();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),

                   */
                ],
              ),
            ),
          ),
          SizedBox(height:5),
          Divider(color: Colors.grey.shade300.withOpacity(0.5),),
          SizedBox(height:5),
        ],
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Add ' + nameEn + " to today's food?"),
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

                Map<String, dynamic> jsonFileContent =
                json.decode(jsonFile.readAsStringSync());

                if (fileContent[foodEatenDateKey] != null){
                  setState(() {


                    final regExp = new RegExp(r'(?:\[)?(\[[^\]]*?\](?:,?))(?:\])?');
                    String temp = tempFoodEatenList.toString();
                    final input = temp;
                    var result = regExp.allMatches(input).map((m) => m.group(1))
                        .map((String item) => item.replaceAll(new RegExp(r'[\[\],]'), ''))
                        .map((m) => [m])
                        .toList();
                    print(result);

                    List<String> toAdd = [(nameEn + " x1".toString()), (double.parse(cal)).toString()];

                    result.add(toAdd);
                    foodEatenList = result.toString();
                    jsonFileContent[foodEatenDateKey] = foodEatenList;
                    //jsonFile.writeAsStringSync(json.encode(jsonFileContent));

                  });
                  //tempFoodEatenList.add([foodInfo[0], foodInfo[1]]);
                  //foodEatenList = tempFoodEatenList.toString();

                } else {
                  setState(() {
                    tempFoodEatenList= [[(nameEn  + " x1.0"), cal]];
                  });
                  foodEatenList = tempFoodEatenList.toString();
                  writeToFile(foodEatenDateKey, foodEatenList);
                  jsonFileContent[foodEatenDateKey] = foodEatenList;

                }

                if(fileContent[calEatenDateKey] != null) {
                  print("if executed");
                  jsonFileContent[calEatenDateKey] = (double.parse(jsonFileContent[calEatenDateKey]) +(double.parse(cal))).toString();

                } else {
                  print("else executed");
                  String newFoodCal = cal;
                  writeToFile(calEatenDateKey, "$newFoodCal");

                  //writeToFile(foodEatenDateKey, foodEatenList)
                  jsonFileContent[calEatenDateKey] = newFoodCal;

                  //jsonFileContent[calEatenDateKey] = foodInfo[1];


                }

                jsonFile.writeAsStringSync(json.encode(jsonFileContent));
                print(jsonFile.toString());


                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
