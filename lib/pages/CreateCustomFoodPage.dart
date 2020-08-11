import 'package:flutter/material.dart';
import 'package:flutter_app/info/foodData.dart';
import 'package:flutter_app/pages/MyFoodPage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../main.dart';


class CreateCustomFoodPage extends StatefulWidget {
  @override
  _CreateCustomFoodPageState createState() => _CreateCustomFoodPageState();
}

class _CreateCustomFoodPageState extends State<CreateCustomFoodPage> {

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String query;

  TextEditingController foodNameController = new TextEditingController();
  TextEditingController caloriesController = new TextEditingController();


  bool isCustomIngredient = false;
  List<dynamic> myFoodList = [];
  List<dynamic> customIngredientsList = [];
  List<dynamic> searchedIngredients = [];
  String foodName;
  int calories;
  double ingredientServing = 1;

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
      if (fileContent['myFoodList'] == null) {
        // don't do shit
      } else { // not null
        myFoodList = fileContent['myFoodList'];
        print(myFoodList);
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
              "Create a Custom Food",
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
                                    Text("Menu Name"),
                                  ],
                                ),
                                TextFormField(
                                  validator: (value) => value.isEmpty ? 'Please enter your manu name' : null,
                                  controller: foodNameController,
                                  onChanged: (value){
                                    setState(() {
                                      foodName = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      //border: InputBorder.none,
                                      hintText: 'Ex: Food Name'
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add MiraCal Ingredients?"),
                  Switch(
                    value: isCustomIngredient,
                    onChanged: (value) {
                      setState(() {
                        isCustomIngredient = value;
                        print(isCustomIngredient);
                      });
                    },
                    activeTrackColor: Palette.miraCalPink.withOpacity(0.5),
                    activeColor: Palette.miraCalPink,
                  ),

                ],
              ),
            ),
            isCustomIngredient
                ? Column(
                  children: [
                    SizedBox(height:10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:30),
                      child: Row(
                        children: [
                          Text("Ingredients", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    SizedBox(height:10),
                    customIngredientsList.length ==0 ? Container() : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        //controller: _controller,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: customIngredientsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width*0.6,
                                    child: Text(customIngredientsList[index][0].toString())),
                                Text(customIngredientsList[index][1].toString() + " Cal"),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: (){
                                    setState(() {
                                      customIngredientsList.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: MediaQuery.of(context).size.width-60,
                      child: OutlineButton(
                        //borderSide: BorderSide(width: 1),
                        onPressed: (){
                          _showModalIngredientsList(context);
                          setState(() {
                            query = '';
                            searchedIngredients = [];
                          });
                        },
                        child: Text("Add Ingredients"),
                      ),
                    ),
                  ],
                )
                : Container(),
            SizedBox(height:10),
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

                      if (isCustomIngredient){

                        int customCalories = 0;
                        for(int i = 0; i < customIngredientsList.length; i++) {
                          customCalories += customIngredientsList[i][1];
                        }

                        //add or delete food with ingredients
                        addMyFoodWithIngredient(foodName, customCalories, customIngredientsList);

                        Map<String, dynamic> jsonFileContent =
                        json.decode(jsonFile.readAsStringSync());

                        if (fileContent["myFoodList"] == null) {
                          writeToFile("myFoodList", myFoodList);
                          jsonFileContent["myFoodList"] = myFoodList;
                        } else {
                          fileContent['myFoodList'] = myFoodList;
                          jsonFileContent["myFoodList"] = fileContent['myFoodList'];

                        }
                        // this edits the original json data source
                        jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this saves



                      } else {
                        // add or delete food without ingredients
                        addMyFood(foodName, calories);

                        Map<String, dynamic> jsonFileContent =
                        json.decode(jsonFile.readAsStringSync());

                        if (fileContent["myFoodList"] == null) {
                          writeToFile("myFoodList", myFoodList);
                          jsonFileContent["myFoodList"] = myFoodList;
                        } else {
                          fileContent['myFoodList'] = myFoodList;
                          jsonFileContent["myFoodList"] = fileContent['myFoodList'];

                        }
                        // this edits the original json data source
                        jsonFile.writeAsStringSync(json.encode(jsonFileContent)); // this saves

                      }

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyFoodPage()),
                      );
                    }




                  },
                  child: Container(
                    child: Stack(
                      children: [

                        Center(

                            child: Text("Save to My Menu", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
                      ],
                    ),
                  )
              ),
            ),


          ],
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

  void addMyFood(String foodname,int calories){
    bool isEnglish = alphabet.contains(foodname.toLowerCase()[0]);
    if (isEnglish){
      myFoodList.add([foodname,"",calories,"no","no"]);//ช่องสุดท้ายไว้เผื่อใส่รูป
    }else{
      myFoodList.add(["",foodname,calories,"no","no" ]);//ช่องสุดท้ายไว้เผื่อใส่รูป
    }
  }



  void addMyFoodWithIngredient(String foodname,int calories, List<dynamic> ingredient){
    bool isEnglish = alphabet.contains(foodname.toLowerCase()[0]);
    if (isEnglish){
      myFoodList.add([foodname,"",calories,ingredient,"no"]);//ช่องสุดท้ายไว้เผื่อใส่รูป
    }else{
      myFoodList.add(["",foodname,calories,ingredient,"no"]);//ช่องสุดท้ายไว้เผื่อใส่รูป
    }
  }

  void deleteMyFood(String foodname){
    bool isEnglish = alphabet.contains(foodname.toLowerCase()[0]);
    int language_index = 1;
    if (isEnglish){ language_index = 0;}
    for(int i = 0;i < myFoodList.length;i++){
      if(myFoodList[i][language_index].toLowerCase().contains(foodname.toLowerCase())){
        myFoodList.removeAt(i);
      }
    }
  }

  _showModalIngredientsList(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("MiraCal Ingredients"),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: TextFormField(
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'Search...',
                          ),
                          onChanged: (value) {
                            setState(() {
                              query = value;
                              print(searchedIngredients);
                              searchedIngredients = searchingIngredient(query);

                            });
                            setState(() {
                              searchedIngredients = searchingIngredient(query);
                            });
                          },
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                            print("saved");
                            setState(() {
                              query = value;
                              searchedIngredients = searchingIngredient(query);

                            });
                          },

                        ),
                      ),
                      OutlineButton(
                        onPressed: (){
                          FocusScope.of(context).unfocus();
                        },
                        child: Text("Search"),
                      ),
                    ],
                  ) ,
                  SizedBox(height:10),


                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      //controller: _controller,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: this.searchedIngredients.length,
                      itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            List<dynamic> foodInfo = [this.searchedIngredients[index][0], this.searchedIngredients[index][1]];
                            _showConfirmationDialog(foodInfo);
                          },
                          child: Container(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              key: UniqueKey(),
                              children: [
                                Container(

                                    child: Text(this.searchedIngredients[index][0]),
                                  width: MediaQuery.of(context).size.width*0.6,
                                ),

                                Container(

                                  child: Text(this.searchedIngredients[index][1].toString() + " Cal"),

                                ),

                              ],
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  })



                ],
              ),
            ),
          );
        });
  }

  void addMenu (List<dynamic> menuList,List<dynamic> tem_result,String foodname,int language_index){
    for(int i = 0;i<menuList.length;i++){
      if(menuList[i][language_index].toLowerCase().contains(foodname.toLowerCase())){
        double accuracy_percent = ((foodname.length/menuList[i][language_index].length)*10000).round()/100;
        tem_result.add([menuList[i][language_index],menuList[i][2],menuList[i][4],accuracy_percent]);
      }
    }
  }

  List<dynamic> getRange(List<dynamic> tem_result,int endpoint){
    List<dynamic> result = [];
    for(int i = 0;i<tem_result.length && i < endpoint;i++){
      tem_result[i].removeLast();
      result.add(tem_result[i]);
    }
    return(result);
  }

  List<dynamic> searchingIngredient(String ingredientname){
    bool isEnglish = alphabet.contains(ingredientname.toLowerCase()[0]);
    int language_index = 1;
    if (isEnglish){ language_index = 0;}
    List<dynamic> tem_result = [];
    addMenu(FoodData.ingredientsList,tem_result,ingredientname,language_index);
    bubbleSort(tem_result);
    List<dynamic> result = getRange(tem_result,10);
    return result;
  }

  Future<void> _showConfirmationDialog(List<dynamic> foodInfo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(foodInfo[0] + " " + foodInfo[1].toString() + " Cal"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                //Text("How many servings do you wish to add?"),

                Row(
                  children: [
                    Container(
                      width: 50,
                      child: Form(
                        key: _formKey2,
                        child: TextFormField(
                          validator: (value) => value.isEmpty ? "Invalid serving" : null,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          initialValue: "1",
                          onChanged: (value){
                            setState(() {
                              ingredientServing = double.parse(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Text(" Serving(s)"),
                  ],
                ),

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
                List<dynamic> ingredientInfo = [foodInfo[0] + " x "+ ingredientServing.toString(), (foodInfo[1]*ingredientServing).ceil()];

                setState(() {
                  customIngredientsList.add(ingredientInfo);
                });





                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }






}
