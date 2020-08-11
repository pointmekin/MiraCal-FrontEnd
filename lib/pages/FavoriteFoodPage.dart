import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'FoodDetails.dart';

class FavoriteFoodPage extends StatefulWidget {
  @override
  _FavoriteFoodPageState createState() => _FavoriteFoodPageState();
}

class _FavoriteFoodPageState extends State<FavoriteFoodPage> {

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

  @override
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
              "Favorite Food",
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
              SizedBox(width: 15,),f
            ],

             */
          ),

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [



            SizedBox(height:10),

            fileContent['favoriteFoodList'] == null || fileContent['favoriteFoodList'].length == 0
                ? Center(child: Text("You have not added any Favorite Food"))
                : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: fileContent['favoriteFoodList'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            String foodName =
                            fileContent['favoriteFoodList'][index][nameLanguageIndex];
                            String foodCal =
                            fileContent['favoriteFoodList'][index][2].toString();
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
                          child: Container(

                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width*0.65,
                                        child: Text(fileContent['favoriteFoodList'][index][nameLanguageIndex], style: TextStyle(fontSize: 15, ),)),
                                    Container(
                                        //width: MediaQuery.of(context).size.width*0.2,
                                        child: Text(fileContent['favoriteFoodList'][index][2].toString() + " Cal", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Palette.miraCalPink),)),

                                  ],
                                ),
                                SizedBox(height:5),
                                Row(
                                  children: [
                                    Text(fileContent['favoriteFoodList'][index][4], style: TextStyle(fontSize: 15, color: Colors.grey),),
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
