import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //systemNavigationBarColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white, // navigation bar color
        //systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark
      //statusBarColor: Colors.pink, // status bar color
    ));

    return Container(
      //color: Palette.whiteThemeBackgroundColor,
      child: Center(
        child: SpinKitChasingDots(
          color: Palette.miraCalPink,
          size: 50,

        ),
      ),
    );
  }
}
