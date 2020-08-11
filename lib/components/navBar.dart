import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Blog.dart';
import 'package:flutter_app/pages/Food.dart';
import 'package:flutter_app/pages/Profile.dart';
import 'package:flutter_app/pages/Workout.dart';
import '../pages/HomePage.dart';



class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 2;

  int _seletedItem = 0;
  var _pages = [Workout(), Food(), HomePage(), Blog(), Profile()];
  var _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return (
        CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 2,

          height: 60.0,
          items: <Widget>[

            Icon(Icons.directions_run, size: 30),
            Icon(Icons.fastfood, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.speaker_notes, size: 30),
            Icon(Icons.person, size: 30),
          ],
          color: Colors.white60,
          buttonBackgroundColor: Colors.white60,
          backgroundColor: Colors.grey.shade200,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _seletedItem = index;
              _pageController.animateToPage(_seletedItem,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            });
          },
        )
    );
  }
}
