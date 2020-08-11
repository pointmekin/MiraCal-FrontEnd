import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter_app/pages/Question2.dart';
import 'Question3.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Question2point5 extends StatefulWidget {
  @override
  _Question2point5State createState() => _Question2point5State();
}

class _Question2point5State extends State<Question2point5> {

  ////////////////////////////
  // IMPORTANT STATES TO SAVE
  String weightGoal;
  String goalDifficulty;
  ////////////////////////////
  ///////////////////////////
  // JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  String defaultHeight;

  ////////////////////////////



  final elements1 = [
    "Select Difficulty",
    "Easy: 1400-1500 Cal / day",
    "Medium: 1400-1500 Cal / day",
    "Hard: 1400-1500 Cal / day"
  ];

  int selectedIndex1 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists) this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
            child: Column(
              children: [
                SizedBox(height: 70,),
                Text("Tell us about your goal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),

                Container(
                  color: Colors.grey.shade200,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: (Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [



                        InkWell(
                          onTap: () {
                            print('WeightCard Clicked');
                          },
                          splashColor: Colors.white12,
                          focusColor: Colors.white30,
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                              padding: EdgeInsets.fromLTRB(20, 10, 25, 10),
                              height: 120,
                              width: MediaQuery.of(context).size.width-50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15,),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                "What is your weight goal?",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 22),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ]),


                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.15,
                                    child: Form(
                                      autovalidate: true,
                                      onChanged: () {
                                        Form.of(primaryFocus.context).save();
                                      },
                                      child: TextFormField(
                                        decoration: const InputDecoration(

                                          hintText: 'ex: 70 kg',

                                        ),
                                        onChanged: (String value){
                                          weightGoal = value;
                                          print("height is " + weightGoal);
                                        },
                                        onSaved: (String value) {
                                          // This optional block of code can be used to run
                                          // code when the user saves the form.
                                          print("saved");
                                        },

                                        validator: (String value) {
                                          return value.contains('@') ? 'Do not use the @ char.' : null;
                                        },
                                      ),
                                    ),
                                  ),


                                  //SizedBox(height: 20,),



                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
                SizedBox(height:20),

                //SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "What is your goal?",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DirectSelect(

                      itemExtent: 35.0,

                      selectedIndex: selectedIndex1,
                      backgroundColor: Colors.grey.shade200,
                      child: MySelectionItem(
                        isForList: false,
                        title: elements1[selectedIndex1],
                      ),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedIndex1 = index;
                          goalDifficulty = elements1[index];
                        });
                      },
                      items: _buildItems1()),
                ),
                SizedBox(height:30),
                (weightGoal != null && goalDifficulty != "Select Difficulty") ? InkWell(
                  onTap: () {
                    print('WeightCard Clicked');
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
                    padding: EdgeInsets.fromLTRB(20, 10, 25, 10),
                    height: 100,
                    width: 380,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15,),

                        Text(
                          "Results",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(height:10),
                        Text(
                          "The duration of this program is 16 weeks.",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                        //SizedBox(height: 20,),



                      ],
                    ),
                  ),
                ) : Container(),

                /*
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "What is your goal?",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                SizedBox(height:20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DirectSelect(

                      itemExtent: 35.0,

                      selectedIndex: selectedIndex1,
                      backgroundColor: Colors.grey.shade200,
                      child: MySelectionItem(
                        isForList: false,
                        title: elements1[selectedIndex1],
                      ),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedIndex1 = index;
                        });
                      },
                      items: _buildItems1()),
                ),

                 */
                SizedBox(height:20),

              ],
            ),
          ),
          Container(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [

                      Container(color:Colors.black,
                        height: 10,
                        width: MediaQuery.of(context).size.width*0.5,),
                      Container(color:Colors.grey,
                        height: 5,
                        width: MediaQuery.of(context).size.width*0.3,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.navigate_before, color: Colors.black, size: 40,),
                        onPressed: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Question2()),
                          );
                        },
                      ),SizedBox(height:20),



                      IconButton(
                        icon: Icon(Icons.navigate_next, color: Colors.black, size: 40,),
                        onPressed: (){

                          writeToFile("weightGoal", weightGoal.toString());
                          writeToFile("goalDuration", goalDifficulty);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Question3()),
                          );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
        child: _buildItem(context),
        padding: EdgeInsets.all(10.0),
      )
          : Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _buildItem(context),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title, style: TextStyle(fontSize: 16),),
    );
  }
}
