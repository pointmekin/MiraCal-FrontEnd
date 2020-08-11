import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/HomeBasePage.dart';
import 'package:flutter_app/pages/Question1.dart';
import 'package:flutter_app/pages/Splashscreen.dart';
import 'package:flutter_app/services/Auth.dart';
import 'package:provider/provider.dart';
import 'components/WeightCard.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'models/User.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black//Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black, // navigation bar color
    //systemNavigationBarIconBrightness: Brightness.light
    //statusBarColor: Colors.white, // status bar color
  ));


  // IMPORTANT //
  // Change the "RED SCREEN OF DEATH" to a blank container. Uncomment this when releasing the app
  //ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: DynamicTheme(
        data:(brightness) {
          return ThemeData(
            brightness: brightness == Brightness.dark ? Brightness.dark : Brightness.light,
            fontFamily: 'Lato',
            primaryColor: brightness == Brightness.dark ? Colors.black : Colors.white,//generateMaterialColor(Palette.primary),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: brightness == Brightness.dark ? Colors.black : Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black)
          );
        },

        themedWidgetBuilder: (context, theme) {
          return MaterialApp(





              builder: (context, child) {







                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: child,
                  ),
                );
              },
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: theme,
              home: Splashscreen()//HomeBasePage(),
          );
        },

      ),
    );
  }
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

class Palette {
  static const Color primary = Color(0xFF616161);
  static const Color miraCalPink = Color(0xFFE39090);
  static Color whiteThemeBackgroundColor = Colors.white;//Colors.grey.shade200;
  //static Color whiteThemeBackgroundColor = Colors.grey.shade200;
}

class dailyInfo {
  static int calEatenToday = 0;
  static int calBurnedToday = 0;


}

