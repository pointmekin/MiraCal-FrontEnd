import 'package:flutter/material.dart';
import '../components/BlogsCard.dart';

import 'Calendar.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  String userName = "Point";
  double cardWidth;
  var whiteThemeColor = Colors.grey.shade200;
  var darkThemeColor = Colors.black;

  ScrollController _controller = new ScrollController();



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
              "Blog",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 200,
                    child: BlogsCard(),
                  );
                },
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Divider(color: Colors.grey),
            ),

          ],
        ),
      ),
      //bottomNavigationBar: NavBar(),
    );
  }
}
