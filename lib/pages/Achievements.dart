import 'package:flutter/material.dart';

import 'Calendar.dart';

class Achievements extends StatefulWidget {
  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  String userName = "Point";
  double cardWidth;
  var whiteThemeColor = Colors.grey.shade200;
  var darkThemeColor = Colors.black;

  List<int> blogsList = [1,2,3,4];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteThemeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "Achievements",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
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
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        print("Go to calendar page");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Calendar()),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                print('Blog card Clicked');
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
                padding: EdgeInsets.fromLTRB(20, 15, 25, 10),
                height: 200,
                width: 380,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [

                                Text(
                                  "Workout Achievements",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 26),
                                ),
                              ],
                            ),
                          ),

                        ]
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("Achievements go here"),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Divider(color: Colors.grey),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                print('Blog card Clicked');
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
                padding: EdgeInsets.fromLTRB(20, 15, 25, 10),
                height: 200,
                width: 380,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [

                                Text(
                                  "Food Achievements",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 26),
                                ),
                              ],
                            ),
                          ),

                        ]
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("Achievements go here"),
                    ),
                  ],
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                ],
              ),
            ),


          ],
        ),
      ),
      //bottomNavigationBar: NavBar(),
    );
  }
}
