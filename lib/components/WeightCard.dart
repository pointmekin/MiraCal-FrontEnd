import 'package:flutter/material.dart';

class WeightCard extends StatefulWidget {
  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  String dropdownValue = 'Weekly';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: (Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          InkWell(
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
              height: 160,
              width: MediaQuery.of(context).size.width-50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.track_changes,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Weight",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 26),
                              ),
                            ],
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          dropdownColor: Colors.grey.shade200,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              print("change to $dropdownValue view");
                            });
                          },
                          items: <String>['Weekly', 'Monthly', 'Yearly',]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                        )
                      ]),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
