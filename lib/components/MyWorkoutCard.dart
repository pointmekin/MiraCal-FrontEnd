import 'package:flutter/material.dart';
import 'package:flutter_app/pages/MyFoodPage.dart';
import 'package:flutter_app/pages/MyWorkoutPage.dart';

import '../main.dart';

class MyWorkoutCard extends StatelessWidget {

  Color gradientStart = Colors.transparent;
  Color gradientEnd = Palette.miraCalPink.withOpacity(0.7);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width-60)*0.5-15,
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyWorkoutPage()),
            );
          },
          child: Container(
            child: Stack(
              children: [

                Center(

                    child: Text("My Workout", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))),
              ],
            ),
          )
      ),
    );
  }
}
