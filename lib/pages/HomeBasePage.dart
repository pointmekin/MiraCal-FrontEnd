import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/pages/Question1.dart';
import 'package:provider/provider.dart';
import 'Blog.dart';
import 'Food.dart';
import 'Profile.dart';
import 'HomePage.dart';
import 'Workout.dart';
import 'package:flutter_app/main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';



class HomeBasePage extends StatefulWidget {
  HomeBasePage({Key key}) : super(key: key);

  @override
  _HomeBasePageState createState() => _HomeBasePageState();
}

class _HomeBasePageState extends State<HomeBasePage> with SingleTickerProviderStateMixin {

  ////// JSON Stuff
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;


  int thisIndex = 1;
  int currentIndex = 0;
  int _selectedItem = 2;
  int newIndex;
  bool skippedPages = false;
  var _pages = [/*Workout(),*/ Food(), HomePage(), /*Blog()*/ Profile()];
  var _pageController = PageController();
  bool allowChange = true;

  TabController controller;


  GlobalKey _bottomNavigationKey = GlobalKey();



  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 2);
    super.initState();

    controller = new TabController(vsync: this, length: 4, initialIndex: 0);
    setState(() {
      currentIndex = controller.index;
    });

    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if (fileExists && mounted)
        this.setState(
                () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });



    //controller.addListener(_handleTabChange);

  }
/*
  void _handleTabChange() {
    setState(() {
      currentIndex = controller.index;
    });


  }


 */
  void startTimer() {
    Future.delayed(const Duration(milliseconds: 90), () {
      allowChange = false;
      setState(() {
        // Here you can write your code for open new view
        allowChange = true;
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Palette.whiteThemeBackgroundColor,
/*
      body: PageView(
        //physics: NeverScrollableScrollPhysics(),
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedItem = index;
            print('changed to page $index');
          });
        },
        controller: _pageController,
      ),

 */
        bottomNavigationBar: Container(
          height: 65,
          child: Column(
            children: [
              new Material(
                  color: Colors.transparent,
                  child: new TabBar(

                    // old indicator
                    /*
                      indicator: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: Palette.miraCalPink,
                              width: 3.0,
                          ),
                        ),
                      ),

                     */
                      indicator: CircleTabIndicator(color: Palette.miraCalPink, radius: 3),

                      controller: controller,
                      indicatorWeight: 5,
                      tabs: <Tab>[
                        new Tab(icon: new Icon(Icons.home,)),
                        new Tab(icon: new Icon(Icons.directions_run,)),
                        new Tab(icon: new Icon(Icons.local_dining,)),
                        new Tab(icon: new Icon(Icons.person, )),
                        /*
                        new Tab(icon: new Icon(Icons.home, color: currentIndex == 0 ? Palette.miraCalPink : Colors.black,)),
                        new Tab(icon: new Icon(Icons.directions_run, color: currentIndex == 1 ? Palette.miraCalPink : Colors.black,)),
                        new Tab(icon: new Icon(Icons.local_dining, color: currentIndex == 2 ? Palette.miraCalPink : Colors.black,)),
                        new Tab(icon: new Icon(Icons.person, color: currentIndex == 3 ? Palette.miraCalPink : Colors.black,)),
                         */
                      ]
                  )
              ),

            ],
          ),
        ),
        body: new TabBarView(
            controller: controller,


            children: <Widget>[
              new HomePage(),
              new Workout(),
              new Food(),
              new Profile(),
            ]
        ),

      // 2nd attempt of the nav bar
      /*
      CurvedNavigationBar(

        key: _bottomNavigationKey,
        index: _selectedItem,

        height: 60.0,
        items: <Widget>[

          //Icon(Icons.directions_run, size: 30),
          Icon(Icons.local_dining, size: 30),
          Icon(Icons.home, size: 30),
          //Icon(Icons.speaker_notes, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.white60,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.grey.shade200,
        //animationCurve: Curves.easeOutCubic,
        //animationDuration: Duration(milliseconds: 600, ),
        onTap: (index) {
          setState(() {
            newIndex = index;


            _selectedItem = index;
            _pageController.animateToPage(newIndex,
                duration: Duration(milliseconds: 600), curve: Curves.easeOutSine);

            startTimer();
          });
        },
      ),

       */

      //This is the default nav bar, I'll save this here just in case
      /*
      BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo), title: Text('Photos')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Profile'))
        ],
        currentIndex: _seletedItem,
        onTap: (index) {
          setState(() {
            _seletedItem = index;
            _pageController.animateToPage(_seletedItem,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          });
        },
      ),

      */
    );


  }


}



class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
    ..color = color
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
