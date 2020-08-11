import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/Food.dart';
import 'FoodSearch2.dart';
import 'package:flutter_app/info/foodData.dart';
import 'package:flutter_app/pages/FoodDetails.dart';

class FoodCategories extends StatefulWidget {
  @override
  _FoodCategoriesState createState() => _FoodCategoriesState();
}

class _FoodCategoriesState extends State<FoodCategories> {

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


  @override
  Widget build(BuildContext context) {



    return DefaultTabController(
      length: 5,
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
                        MaterialPageRoute(builder: (context) => FoodSearch2()),
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
                        child: Text('Meal'),
                      ),
                      Tab(
                        child: Text('Drinks'),
                      ),
                      Tab(
                        child: Text('Ingredients'),
                      ),
                      Tab(
                        child: Text('Dessert'),
                      ),
                      Tab(
                        child: Text('Snacks'),
                      ),

                    ]),
                preferredSize: Size.fromHeight(200.0),
              ),



            ),
          ),

        ),
        body: TabBarView(
          children: <Widget>[
            //Meal
            Scrollbar(
              child: SingleChildScrollView(
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton.icon(onPressed: (){
                            setState(() {
                              showAllMeals = !showAllMeals;
                            });
                          },
                              icon: Icon(Icons.format_list_bulleted),
                              label: showAllMeals ? Text("Show Meal Categories") : Text("Show All Meals")),
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


                    showAllMeals
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: FoodData.mealList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: InkWell(
                                  onTap: () {
                                    String foodName =
                                    FoodData.mealList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                                    String foodCal =
                                    FoodData.mealList[index][2].toString();
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
                                              child: Text(FoodData.mealList[index][nameLanguageIndex])),
                                          SizedBox(width:10),
                                          Container(child: Text(FoodData.mealList[index][2].toString() + " Cal")),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Column(
                      children: [
                        //Divider(),
                        SizedBox(height:10),
                        InkWell(
                          onTap: (){
                            print("Thai clicked");
                            setState(() {
                              showThaiDetails = !showThaiDetails;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Thai", style: TextStyle(fontSize: 18),),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                        ),

                        !showThaiDetails ? Container() : Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  print("Thai Northern clicked");
                                  setState(() {
                                    showAllMeals = false;
                                    showNorthernMeal = !showNorthernMeal;
                                  });

                                  },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Thai Northern", style: TextStyle(fontSize: 18),),
                                      Icon(Icons.navigate_next)
                                    ],
                                  ),
                                ),

                              ),
                              showNorthernMeal ? NorthernFoodList() : Container(),
                              InkWell(
                                onTap: (){
                                  print("Thai Southern clicked");
                                  setState(() {
                                    showSouthernMeal = !showSouthernMeal;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Thai Southern", style: TextStyle(fontSize: 18),),
                                      Icon(Icons.navigate_next)
                                    ],
                                  ),
                                ),

                              ),
                              showSouthernMeal ? SouthernFoodList() : Container(),
                              InkWell(
                                onTap: (){
                                  print("Thai Northeastern (Isarn) clicked");
                                  setState(() {
                                    showIsarnMeal = !showIsarnMeal;
                                  });
                                  },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Thai Northeastern (Isarn)", style: TextStyle(fontSize: 18),),
                                      Icon(Icons.navigate_next)
                                    ],
                                  ),
                                ),

                              ),
                              showIsarnMeal ? IsarnFoodList() : Container(),
                              InkWell(
                                onTap: (){
                                  print("Other clicked");
                                  setState(() {
                                    showOtherThaiMeal = !showOtherThaiMeal;
                                  });
                                  },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Other", style: TextStyle(fontSize: 18),),
                                      Icon(Icons.navigate_next)
                                    ],
                                  ),
                                ),

                              ),
                              showOtherThaiMeal ? OtherThaiFoodList() : Container(),

                            ],
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: (){
                            print("Japanese clicked");
                            setState(() {
                              showJapaneseMeal = !showJapaneseMeal;
                            });
                            },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Japanese", style: TextStyle(fontSize: 18),),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                        ),
                        showJapaneseMeal ? JapaneseFoodList() : Container(),
                        Divider(),
                        InkWell(
                          onTap: (){
                            print("Chinese clicked");
                            setState(() {
                              showChineseMeal = !showChineseMeal;
                            });
                            },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Chinese", style: TextStyle(fontSize: 18),),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                        ),
                        showChineseMeal ? ChineseFoodList() : Container(),
                        Divider(),
                        InkWell(
                          onTap: (){
                            print("Western clicked");
                            setState(() {
                              showWesternMeal = !showWesternMeal;
                            });
                            },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Western", style: TextStyle(fontSize: 18),),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                        ),
                        showWesternMeal ? WesternFoodList() : Container(),
                        Divider(),
                        InkWell(
                          onTap: (){
                            print("Other clicked");
                            setState(() {
                              showOtherMeal = !showOtherMeal;
                            });
                            },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Other", style: TextStyle(fontSize: 18),),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                        ),
                        showOtherMeal ? OtherFoodList() : Container(),
                        Divider(),
                      ],
                    ),


                  ],
                ),
              ),
            ),
            // Drinks
            SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton.icon(onPressed: (){
                          setState(() {
                            showAllDrinks = !showAllDrinks;
                          });
                        },
                            icon: Icon(Icons.format_list_bulleted),
                            label: showAllDrinks ? Text("Show Drinks Categories") : Text("Show All Drinks")),
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
                  showAllDrinks
                      ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: FoodData.drinksList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              String foodName =
                              FoodData.drinksList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                              String foodCal =
                              FoodData.drinksList[index][2].toString();
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
                                        child: Text(FoodData.drinksList[index][nameLanguageIndex])),
                                    SizedBox(width:10),
                                    Container(child: Text(FoodData.drinksList[index][2].toString() + " Cal")),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      : Column(
                    children: [
                      //Divider(),
                      SizedBox(height:10),
                      InkWell(
                        onTap: (){
                          print("Soft drinks clicked");
                          setState(() {
                            showSoftDrinks = !showSoftDrinks;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Soft Drinks", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showSoftDrinks ? SoftDrinksList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Coffee clicked");
                          setState(() {
                            showCoffee = !showCoffee;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Coffee", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showCoffee ? CoffeeList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Tea clicked");
                          setState(() {
                            showTea = !showTea;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tea", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showTea ? TeaList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Alcohol clicked");
                          setState(() {
                            showAlcohol = !showAlcohol;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Alcohol", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showAlcohol ? AlcoholList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Cold/Hot Drinks clicked");
                          setState(() {
                            showColdHotDrinks = !showColdHotDrinks;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cold/Hot Drinks", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showColdHotDrinks ? ColdHotDrinksList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Juice clicked");
                          setState(() {
                            showJuice = !showJuice;
                          });

                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Juice", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showJuice ? JuiceList() : Container(),
                      Divider(),
                    ],
                  ),
                ],
              ),
            ),
            // Ingredients
            SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton.icon(onPressed: (){
                          setState(() {
                            showAllIngredients = !showAllIngredients;
                          });
                        },
                            icon: Icon(Icons.format_list_bulleted),
                            label: showAllIngredients ? Text("Show Ingredient Categories") : Text("Show All Ingredients")),
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
                  showAllIngredients
                      ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: FoodData.ingredientsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              String foodName =
                              FoodData.ingredientsList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                              String foodCal =
                              FoodData.ingredientsList[index][2].toString();
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
                                        child: Text(FoodData.ingredientsList[index][nameLanguageIndex])),
                                    SizedBox(width:10),
                                    Container(child: Text(FoodData.ingredientsList[index][2].toString() + " Cal")),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      : Column(
                    children: [
                      //Divider(),
                      SizedBox(height:10),
                      InkWell(
                        onTap: (){
                          print("Vegetables clicked");
                          setState(() {
                            showVegetables = !showVegetables;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Vegetables", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showVegetables ? VegetablesList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Meat clicked");
                          setState(() {
                            showMeat = !showMeat;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Meat", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showMeat ? MeatList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Carb clicked");
                          setState(() {
                            showCarb = !showCarb;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Carb", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showCarb ? CarbList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Dairy clicked");
                          setState(() {
                            showDairy = !showDairy;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Dairy", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showDairy ? DairyList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Fruits clicked");
                          setState(() {
                            showFruits = !showFruits;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Fruits", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showFruits ? FruitList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("Grains clicked");
                          setState(() {
                            showGrains = !showGrains;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Grains", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showGrains ? GrainsList() : Container(),
                      Divider(),
                    ],
                  ),
                ],
              ),
            ),
            // Dessert
            SingleChildScrollView(

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton.icon(onPressed: (){
                          setState(() {
                            showAllDesserts = !showAllDesserts;
                          });
                        },
                            icon: Icon(Icons.format_list_bulleted),
                            label: showAllDesserts ? Text("Show Dessert Categories") : Text("Show All Desserts")),
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
                  showAllDesserts
                      ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: FoodData.dessertList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              String foodName =
                              FoodData.dessertList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                              String foodCal =
                              FoodData.dessertList[index][2].toString();
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
                                        child: Text(FoodData.dessertList[index][nameLanguageIndex])),
                                    SizedBox(width:10),
                                    Container(child: Text(FoodData.dessertList[index][2].toString() + " Cal")),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      : Column(
                    children: [
                      //Divider(),
                      SizedBox(height:10),
                      InkWell(
                        onTap: (){
                          print("Thai clicked");
                          setState(() {
                            showThaiDessert = !showThaiDessert;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thai", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showThaiDessert ? ThaiDessertList() : Container(),
                      Divider(),
                      InkWell(
                        onTap: (){
                          print("International clicked");
                          setState(() {
                            showInternationalDessert = !showInternationalDessert;
                          });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("International", style: TextStyle(fontSize: 18),),
                              Icon(Icons.navigate_next)
                            ],
                          ),
                        ),
                      ),
                      showInternationalDessert ? InternationalDessertList() : Container(),
                      Divider(),

                    ],
                  ),
                ],
              ),
            ),
            // Snacks
            SingleChildScrollView(
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
                      itemCount: FoodData.snackList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              String foodName =
                              FoodData.snackList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                              String foodCal =
                              FoodData.snackList[index][2].toString();
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
                                        child: Text(FoodData.snackList[index][nameLanguageIndex])),
                                    SizedBox(width:10),
                                    Container(child: Text(FoodData.snackList[index][2].toString() + " Cal")),
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


          ],
        ),


      ),
    );
  }
}

class NorthernFoodList extends StatelessWidget {

  List<dynamic> northernFoodList = FoodData.mealList.where((element) => element[6] == "Northern").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: northernFoodList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    northernFoodList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    northernFoodList[index][2].toString();
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
                              child: Text(northernFoodList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(northernFoodList[index][2].toString() + " Cal")),
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
                    southernFoodList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    southernFoodList[index][2].toString();
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
                              child: Text(southernFoodList[index][_FoodCategoriesState.nameLanguageIndex])),
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
class IsarnFoodList extends StatelessWidget {

  List<dynamic> isarnFoodList = FoodData.mealList.where((element) => element[6] == "isarn").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: isarnFoodList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    isarnFoodList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    isarnFoodList[index][2].toString();
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
                              child: Text(isarnFoodList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(isarnFoodList[index][2].toString() + " Cal")),
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
class JapaneseFoodList extends StatelessWidget {

  List<dynamic> japaneseFoodList = FoodData.mealList.where((element) => element[5] == "japan").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: japaneseFoodList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    japaneseFoodList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    japaneseFoodList[index][2].toString();
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
                              child: Text(japaneseFoodList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(japaneseFoodList[index][2].toString() + " Cal")),
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
class ChineseFoodList extends StatelessWidget {

  List<dynamic> chineseFoodList = FoodData.mealList.where((element) => element[5] == "china").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: chineseFoodList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    chineseFoodList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    chineseFoodList[index][2].toString();
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
                              child: Text(chineseFoodList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(chineseFoodList[index][2].toString() + " Cal")),
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
class WesternFoodList extends StatelessWidget {

  List<dynamic> westernFoodList = FoodData.mealList.where((element) => element[5] == "western").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: westernFoodList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    westernFoodList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    westernFoodList[index][2].toString();
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
                              child: Text(westernFoodList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(westernFoodList[index][2].toString() + " Cal")),
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
class OtherFoodList extends StatelessWidget {

  List<dynamic> otherFoodList = FoodData.mealList.where((element) => element[5] == "other").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: otherFoodList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    otherFoodList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    otherFoodList[index][2].toString();
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
                              child: Text(otherFoodList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(otherFoodList[index][2].toString() + " Cal")),
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
class SoftDrinksList extends StatelessWidget {

  List<dynamic> softDrinksList = FoodData.drinksList.where((element) => element[5] == "Soft drink").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: softDrinksList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    softDrinksList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    softDrinksList[index][2].toString();
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
                              child: Text(softDrinksList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(softDrinksList[index][2].toString() + " Cal")),
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
class CoffeeList extends StatelessWidget {

  List<dynamic> coffeeList = FoodData.drinksList.where((element) => element[5] == "Coffee").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: coffeeList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    coffeeList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    coffeeList[index][2].toString();
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
                              child: Text(coffeeList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(coffeeList[index][2].toString() + " Cal")),
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
class TeaList extends StatelessWidget {

  List<dynamic> teaList = FoodData.drinksList.where((element) => element[5] == "Tea").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: teaList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    teaList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    teaList[index][2].toString();
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
                              child: Text(teaList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(teaList[index][2].toString() + " Cal")),
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
class AlcoholList extends StatelessWidget {

  List<dynamic> alcoholList = FoodData.drinksList.where((element) => element[5] == "Alcohol").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: alcoholList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    alcoholList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    alcoholList[index][2].toString();
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
                              child: Text(alcoholList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(alcoholList[index][2].toString() + " Cal")),
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
class ColdHotDrinksList extends StatelessWidget {

  List<dynamic> coldHotDrinksList = FoodData.drinksList.where((element) => element[5] == "Cold drink" || element[5] == "Hot drink").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: coldHotDrinksList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    coldHotDrinksList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    coldHotDrinksList[index][2].toString();
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
                              child: Text(coldHotDrinksList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(coldHotDrinksList[index][2].toString() + " Cal")),
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
class JuiceList extends StatelessWidget {

  List<dynamic> juiceList = FoodData.drinksList.where((element) => element[5] == "Juice").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: juiceList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    juiceList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    juiceList[index][2].toString();
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
                              child: Text(juiceList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(juiceList[index][2].toString() + " Cal")),
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
class VegetablesList extends StatelessWidget {

  List<dynamic> vegetableList = FoodData.ingredientsList.where((element) => element[5] == "veggies").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: vegetableList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    vegetableList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    vegetableList[index][2].toString();
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
                              child: Text(vegetableList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(vegetableList[index][2].toString() + " Cal")),
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
class MeatList extends StatelessWidget {

  List<dynamic> meatList = FoodData.ingredientsList.where((element) => element[5] == "meat").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: meatList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    meatList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    meatList[index][2].toString();
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
                              child: Text(meatList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(meatList[index][2].toString() + " Cal")),
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
class CarbList extends StatelessWidget {

  List<dynamic> carbList = FoodData.ingredientsList.where((element) => element[5] == "carb").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: carbList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    carbList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    carbList[index][2].toString();
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
                              child: Text(carbList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(carbList[index][2].toString() + " Cal")),
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
class DairyList extends StatelessWidget {

  List<dynamic> dairyList = FoodData.ingredientsList.where((element) => element[5] == "dairy").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: dairyList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    dairyList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    dairyList[index][2].toString();
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
                              child: Text(dairyList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(dairyList[index][2].toString() + " Cal")),
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
class FruitList extends StatelessWidget {

  List<dynamic> fruitList = FoodData.ingredientsList.where((element) => element[5] == "fruit").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: fruitList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    fruitList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    fruitList[index][2].toString();
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
                              child: Text(fruitList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(fruitList[index][2].toString() + " Cal")),
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
class GrainsList extends StatelessWidget {

  List<dynamic> grainList = FoodData.ingredientsList.where((element) => element[5] == "grains").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: grainList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    grainList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    grainList[index][2].toString();
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
                              child: Text(grainList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(grainList[index][2].toString() + " Cal")),
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
class ThaiDessertList extends StatelessWidget {

  List<dynamic> thaiDessertList = FoodData.dessertList.where((element) => element[5] == "thailand").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: thaiDessertList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    thaiDessertList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    thaiDessertList[index][2].toString();
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
                              child: Text(thaiDessertList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(thaiDessertList[index][2].toString() + " Cal")),
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
class InternationalDessertList extends StatelessWidget {

  List<dynamic> internationalDessertList = FoodData.dessertList.where((element) => element[5] == "international").toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: internationalDessertList.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    String foodName =
                    internationalDessertList[index][_FoodCategoriesState.nameLanguageIndex].toString();
                    String foodCal =
                    internationalDessertList[index][2].toString();
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
                              child: Text(internationalDessertList[index][_FoodCategoriesState.nameLanguageIndex])),
                          SizedBox(width:10),
                          Container(child: Text(internationalDessertList[index][2].toString() + " Cal")),
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








/////////////////////////////////////////////////////////////
/*

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:gallery/l10n/gallery_localizations.dart';

class _TabsScrollableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabs = [
      GalleryLocalizations.of(context).colorsRed,
      GalleryLocalizations.of(context).colorsOrange,
      GalleryLocalizations.of(context).colorsGreen,
      GalleryLocalizations.of(context).colorsBlue,
      GalleryLocalizations.of(context).colorsIndigo,
      GalleryLocalizations.of(context).colorsPurple,
      GalleryLocalizations.of(context).colorsRed,
      GalleryLocalizations.of(context).colorsOrange,
      GalleryLocalizations.of(context).colorsGreen,
      GalleryLocalizations.of(context).colorsBlue,
      GalleryLocalizations.of(context).colorsIndigo,
      GalleryLocalizations.of(context).colorsPurple,
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(GalleryLocalizations.of(context).demoTabsScrollingTitle),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              for (final tab in tabs) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (final tab in tabs)
              Center(
                child: Text(tab),
              ),
          ],
        ),
      ),
    );
  }
}



 */
