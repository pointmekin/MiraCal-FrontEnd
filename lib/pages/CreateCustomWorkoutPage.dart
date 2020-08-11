import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/info/foodData.dart';
import 'package:flutter_app/pages/MyFoodPage.dart';
import 'package:flutter_app/pages/MyWorkoutPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../main.dart';


class CreateCustomWorkoutPage extends StatefulWidget {
  @override
  _CreateCustomWorkoutPageState createState() => _CreateCustomWorkoutPageState();
}

class _CreateCustomWorkoutPageState extends State<CreateCustomWorkoutPage> {

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String query;
  var value = "0:30:";

  TextEditingController workoutNameController = new TextEditingController();
  TextEditingController caloriesController = new TextEditingController();


  bool isCustomIngredient = false;
  List<dynamic> myWorkoutList = [];

  String workoutName;
  int calories;
  int duration = 30;


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
      if (fileContent['myWorkoutList'] == null) {
        // don't do shit
      } else { // not null
        myWorkoutList = fileContent['myWorkoutList'];
        print(myWorkoutList);
      }

    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Palette.whiteThemeBackgroundColor,
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(180.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(

              title: Text(
                "Create a Workout",
                //style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: PreferredSize(

                preferredSize: const Size.fromHeight(10.0),
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: Colors.white),
                  child: Container(

                    //color: Colors.blue,
                      height: 100.0,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.5,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Workout Name"),
                                      ],
                                    ),
                                    TextFormField(
                                      validator: (value) => value.isEmpty ? 'Please enter your workout name' : null,
                                      controller: workoutNameController,
                                      onChanged: (value){
                                        setState(() {
                                          workoutName = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        //border: InputBorder.none,
                                          hintText: 'Ex: Workout Name'
                                      ),


                                    ),
                                  ],
                                ),
                              ),
                              isCustomIngredient ? Container() : Container(
                                width: MediaQuery.of(context).size.width*0.2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Calories"),
                                      ],
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.numberWithOptions(),
                                      validator: (value) => value.isNotEmpty ? (double.parse(value) > 0 ? null :"Invalid Integer"): 'Invalid Integer',
                                      controller: caloriesController,
                                      onChanged: (value){
                                        setState(() {
                                          calories = double.parse(value).round();
                                        });
                                      },
                                      decoration: InputDecoration(
                                        //border: InputBorder.none,
                                          hintText: 'Ex: 300'
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
              )
          ),



        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:30.0),
          child: Column(
            children: [

              Row(
                children: [
                  Text("Duration"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(value.toString().substring(0,value.indexOf(":")), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(width:10),
                        Text("hr"),
                        SizedBox(width:10),
                        Text(value.toString().substring(value.indexOf(":")+1,value.indexOf(":")+3), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(width:10),
                        Text("min")
                      ],
                    ),
                  ),
                  FlatButton.icon(onPressed: (){
                    _showModalTimePicker(context);
                  }, icon: Icon(Icons.edit, color: Colors.grey,), label: Text("Change Duration", style: TextStyle(color: Colors.grey),),)

                ],
              ),
              SizedBox(height:20),

              Container(
                width: (MediaQuery.of(context).size.width-60),
                height: 50,

                decoration: BoxDecoration(
                    color: Palette.miraCalPink.withOpacity(0.7),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: InkWell(
                    splashColor: Colors.white,
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    highlightColor: Palette.whiteThemeBackgroundColor,
                    onTap: (){


                      if(_formKey.currentState.validate()){

                        addMyExercise(workoutName + " x $duration mins", calories, duration);
                        print(myWorkoutList);


                        Map<String, dynamic> jsonFileContent =
                        json.decode(jsonFile.readAsStringSync());

                        if (fileContent["myWorkoutList"] == null) {
                          writeToFile("myWorkoutList", myWorkoutList);
                          jsonFileContent["myWorkoutList"] = myWorkoutList;
                        } else {
                          fileContent['myWorkoutList'] = myWorkoutList;
                          jsonFileContent["myWorkoutList"] = fileContent['myWorkoutList'];

                        }
                        // this edits the original json data source
                        jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this sav

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyWorkoutPage()),
                        );



                      }

                      Fluttertoast.showToast(
                          msg: "Saved to My Workout",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                          textColor: Colors.white,
                          fontSize: 16.0
                      );



/*


 */
                    },
                    child: Container(
                      child: Stack(
                        children: [

                          Center(

                              child: Text("Save My Workout", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
                        ],
                      ),
                    )
                ),
              ),





            ],
          ),
        ),
      ),
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


  _showModalTimePicker(context) {
    showModalBottomSheet(
        //isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height*0.4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Change Duration"),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  Center(
                    child: CupertinoTimerPicker(
                      initialTimerDuration: Duration(minutes: 30),

                      mode: CupertinoTimerPickerMode.hm,
                      onTimerDurationChanged: (value){
                        setState(() {
                          this.value = value.toString();
                          duration = 0;
                          duration += int.parse(value.toString().substring(0,value.toString().indexOf(":")))*60;
                          duration += int.parse(value.toString().substring(value.toString().indexOf(":")+1,value.toString().indexOf(":")+3));
                          print(duration);


                        });
                      },
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }


  List<dynamic> getRange(List<dynamic> tem_result,int endpoint){
    List<dynamic> result = [];
    for(int i = 0;i<tem_result.length && i < endpoint;i++){
      tem_result[i].removeLast();
      result.add(tem_result[i]);
    }
    return(result);
  }


  void addMyExercise(String exercisename,int calories,int min){
    bool isEnglish = alphabet.contains(exercisename.toLowerCase()[0]);
    if (isEnglish){
      myWorkoutList.add([exercisename,"",calories,min,"no"]);//ช่องสุดท้ายไว้เผื่อใส่รูป
    }else{
      myWorkoutList.add(["",exercisename,calories,min,"no"]);//ช่องสุดท้ายไว้เผื่อใส่รูป
    }
  }

  void deleteMyExercise(String exercisename){
    bool isEnglish = alphabet.contains(exercisename.toLowerCase()[0]);
    int language_index = 1;
    if (isEnglish){ language_index = 0;}
    for(int i = 0;i < myWorkoutList.length;i++){
      if(myWorkoutList[i][language_index].toLowerCase().contains(exercisename.toLowerCase())){
        myWorkoutList.removeAt(i);
      }
    }
  }












}
