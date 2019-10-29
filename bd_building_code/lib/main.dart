import 'package:bd_building_code/pages/homeScreen/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:bd_building_code/pages/loginScreen/loginScreen.dart';

void main(){
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return runApp(MyApp());
}


// Color.fromRGBO(9, 132, 227,1.0)
// Color.fromRGBO(214, 48, 49,1.0),


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  ThemeData _themeData = ThemeData(
    brightness: Brightness.dark,
    cardColor: Colors.black ,
    primaryColor: Colors.lightBlue[800],
    accentColor: Colors.cyan[600],

    textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    )
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme:_themeData ,
      title: 'Bangladesh Building Code',
      home: AnimatedSplash(
        imagePath: 'assets/bd_code.png',
        duration: 2000,
        type: AnimatedSplashType.BackgroundProcess,
        customFunction: duringSplash,
        outputAndHome: routes,
        home: HomePage(),
      ),
    );
  }
 final Map<int, Widget> routes = {
    1:  HomePage(),
    2: LoginPage()
   };
  final Function duringSplash= (){
    //do some auth logic here 
    int val = 2;
    if(val > 1 ){
      return 2;
    }else{
      return 2 ;
    }
  };


  // static Future<int> checkLoginState() async{
  //   print('Checking Login State');
  //   final authCodeStorage = FlutterSecureStorage();
  //     String authKey = await authCodeStorage.read(key: "loginState");
  //     if(authKey != null ){
  //       return Future.value(1); 
  //     }else {
  //       return Future.value(2);
  //     }
  // }
}


