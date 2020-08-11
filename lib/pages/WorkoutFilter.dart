import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';


class WorkoutFilter extends StatefulWidget {
  @override
  _WorkoutFilterState createState() => _WorkoutFilterState();
}

class _WorkoutFilterState extends State<WorkoutFilter> {
  String userName = "Point";
  double cardWidth;
  var whiteThemeColor = Colors.grey.shade200;
  var darkThemeColor = Colors.black;






  String dropdownValue = '5 min';

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
              "Workout Filter",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
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
            SizedBox(height: 10,),
            // workout duration set
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: MultiSelect(

                  autovalidate: false,
                  titleText: "Which areas do you wish to focus on today?",
                  validator: (value) {
                    if (value == null) {
                      return ('Please select one or more option(s)');
                    }
                  },
                  errorText: 'Please select one or more option(s)',
                  dataSource: [
                    {
                      "display": "Leg",
                      "value": 1,
                    },
                    {
                      "display": "Abs",
                      "value": 2,
                    },
                    {
                      "display": "Chest",
                      "value": 3,
                    },
                    {
                      "display": "etc.",
                      "value": 4,
                    }
                  ],
                  selectIcon: Icons.arrow_drop_down_circle,
                  saveButtonColor: Colors.black,
                  checkBoxColor: Colors.grey,
                  cancelButtonColor: Colors.grey.shade200,


                  textField: 'display',
                  valueField: 'value',
                  filterable: true,
                  required: false,
                  value: null,
                  onSaved: (value) {
                    print('The value is $value');
                  }


              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 450,),
                  Container(
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
                    height: 70,
                    width: 380,
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
                                      Icons.timer,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Workout Duration",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19),
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
                                items: <String>['5 min', '10 min', '20 min', '30 min', '45 min', '1 hour', '1.5 hour', '2 hours']
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
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      print('Filtered WorkoutSearch clicked');
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
                                        Icons.directions_run,
                                        color: Colors.grey.shade200,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Find Workout Recommendations",
                                        style: TextStyle(
                                            color: Colors.grey.shade200,
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


