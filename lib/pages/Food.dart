import 'package:flutter/material.dart';
import 'package:flutter_app/components/FavoriteFoodCard.dart';
import 'package:flutter_app/components/FoodItemCard.dart';
import 'package:flutter_app/components/MyFoodCard.dart';
import 'package:flutter_app/components/foodCalCard.dart';
import 'package:flutter_app/components/foodCalCard2.dart';
import 'package:flutter_app/pages/FoodCategories.dart';
import 'package:flutter_app/pages/FoodSuggestion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'FoodSearch2.dart';
import 'package:flutter_app/main.dart';

class Food extends StatefulWidget {
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  String userName = "Point";
  double cardWidth;
  var whiteThemeColor = Colors.grey.shade200;
  var darkThemeColor = Colors.black;

  TextEditingController searchController = new TextEditingController();
  ScrollController _controller = new ScrollController();




  List foodData;
  /*
  fetchFoodData() async{
    http.Response response =
    await http.get('https://us-central1-miracalapp-e1718.cloudfunctions.net/app/GET/search/foods/:');
    setState(() {
      foodData = json.decode(response.body);
    });
    print("!!! completed fetching");
  }
   */

  @override
  void initState() {
    //TODO: implement initState
    super.initState();


    //fetchFoodData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "Food",

            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[

              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                height: 20,
                width: MediaQuery.of(context).size.width*0.55,
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
                        Text(" Search food")
                      ],
                    ),
                  ),
                ),
              ),
    SizedBox(width: 15,),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text("Today", style: TextStyle(color: Color(0xFFE39090),fontSize: 22, fontWeight: FontWeight.bold),),
                ],
              ),
            ),

            SizedBox(height: 10,),

            FoodCalCard2(),


            //This is the search box
            Container(
              decoration: BoxDecoration(
                //color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
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
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 15),
              /*
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(

                          hintText: "search food ...",
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        /*
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            )
                        ));

                         */
                      },
                      child: Container(child: Icon(Icons.search))),
                ],
              ),

               */
            ),

            //This is a button



            //end of another button
            SizedBox(height:30),
            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  //Icon(Icons.fastfood, color: Palette.miraCalPink,),

                  Text("My Selection", style: TextStyle(color: Color(0xFFE39090),fontSize: 22, fontWeight: FontWeight.bold),),

                ],
              ),
            ),
            SizedBox(height:15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FavoriteFoodCard(),
                  MyFoodCard(),
                ],
              ),
            ),
            SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text("Explore Our Food", style: TextStyle(color: Color(0xFFE39090),fontSize: 22, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            SizedBox(height:15),

            InkWell(
              onTap: () {
                print('Filter Food Clicked');

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodCategories()),
                );

              },
              splashColor: Colors.white12,
              focusColor: Colors.white30,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.3),
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
                  width: 380,
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
                                    Icons.track_changes,
                                    //color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Categories",
                                    style: TextStyle(
                                      //color: Colors.grey.shade200,
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
            ),
            // end of button
            SizedBox(height: 15,),
            //another button
/*
            InkWell(
              onTap: () {
                print('Randomize Food Clicked');
                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodSuggestion()),
                );

                 */

              },
              splashColor: Colors.white12,
              focusColor: Colors.white30,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.3),
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
                  width: 380,
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
                                    Icons.filter_list,
                                    //color: Colors.grey.shade200,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Suggestion (Coming Soon)",
                                    style: TextStyle(
                                      //color: Colors.grey.shade200,
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
            ),
*/

            SizedBox(height: 20,),

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  //Icon(Icons.fastfood, color: Palette.miraCalPink,),
                  SizedBox(width: 5,),
                  Text("MiraCal Recommends", style: TextStyle(color: Color(0xFFE39090),fontSize: 22, fontWeight: FontWeight.bold),),

                ],
              ),
            ),

            SizedBox(height:20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  FoodItemCard(nameEn: "Pad thai with shrimp and egg", cal: "545",),
                  FoodItemCard(nameEn: "Iced Caffè Latte 16 oz (Grande)", cal: "130",),
                  FoodItemCard(nameEn: "Rice with Stif-fried Pork and Basil", cal: "580",),
                  FoodItemCard(nameEn: "Massaman Curry with Chicken", cal: "325",),
                  FoodItemCard(nameEn: "Chicken Curry Rice", cal: "389",),
                  FoodItemCard(nameEn: "Chicken Rice", cal: "596",),
                  FoodItemCard(nameEn: "Crispy Pork Belly with Kale", cal: "420",),
                  FoodItemCard(nameEn: "Tom Yum Kung", cal: "65",),
                  FoodItemCard(nameEn: "Coca-Cola 325 ml", cal: "140",),
                  FoodItemCard(nameEn: "Thai Iced Tea 200 ml", cal: "319",),
                  FoodItemCard(nameEn: "Iced Chocolate 200 ml", cal: "334",),
                  FoodItemCard(nameEn: "Mango with sticky rice (1 serving)", cal: "350",),
                  FoodItemCard(nameEn: "Coconut milk ice cream (1 serving)", cal: "330",),
                  FoodItemCard(nameEn: "Honey Toast (1 piece)", cal: "492",),
                ],
              ),
              /*
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 280,
                    child: FoodItemCard(nameEn: "kuay",),
                  );
                },
              ),

               */

            ),
            SizedBox(
              height: 10,
            ),
// This is a view more button
/*
            Column(
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
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
                    child: Icon(Icons.expand_more),
                  ),
                ),


              ],
            ),

 */
            SizedBox(
              height: 30,
            ),


          ],
        ),
      ),
      //bottomNavigationBar: NavBar(),
    );
  }
}
