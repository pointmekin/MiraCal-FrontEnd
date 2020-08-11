import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';



class FoodSuggestion extends StatefulWidget {
  @override
  _FoodSuggestionState createState() => _FoodSuggestionState();
}

class _FoodSuggestionState extends State<FoodSuggestion> {

  final elements1 = [
    "Breakfast",
    "Lunch",
    "2nd Snack",
    "Dinner",
    "3rd Snack",
  ];
  final elements2 = [
    "Cheese Steak",
    "Chicken",
    "Salad",
  ];

  final elements3 = [
    "7am - 10am",
    "11am - 2pm",
    "3pm - 6pm",
    "7pm-10pm",
  ];

  final elements4 = [
    "Lose fat",
    "Gain muscle",
    "Keep in weight",
  ];

  int selectedIndex1 = 0,
      selectedIndex2 = 0,
      selectedIndex3 = 0,
      selectedIndex4 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }

  List<Widget> _buildItems2() {
    return elements2
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }

  List<Widget> _buildItems3() {
    return elements3
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }

  List<Widget> _buildItems4() {
    return elements4
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            title: Text(
              "Food Suggestion",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "To which meal?",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Search our database by name",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex2,
                    child: MySelectionItem(
                      isForList: false,
                      title: elements2[selectedIndex2],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex2 = index;
                      });
                    },
                    items: _buildItems2()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Select your workout schedule",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex3,
                    child: MySelectionItem(
                      isForList: false,
                      title: elements3[selectedIndex3],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex3 = index;
                      });
                    },
                    items: _buildItems3()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Select your goal",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,

                    selectedIndex: selectedIndex4,
                    child: MySelectionItem(
                      isForList: false,
                      title: elements4[selectedIndex4],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex4 = index;
                      });
                    },
                    items: _buildItems4()),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      print('Randomize Food Clicked');
                    },

                    splashColor: Colors.white12,
                    focusColor: Colors.white30,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFFE39090),
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
                      padding: EdgeInsets.fromLTRB(20, 0, 25, 0),
                      height: 50,

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Container(

                              child: Row(
                                children: [


                                  Text(
                                    "Get our food suggestions!",
                                    style: TextStyle(
                                        color: Colors.grey.shade200,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),

                          ]),
                    ),
                  ),
                ),
              ]
          ),
        ),
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