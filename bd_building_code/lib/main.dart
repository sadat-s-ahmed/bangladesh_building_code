import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:bd_building_code/pages/home_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Bangladesh Building Code',
      home: AnimatedSplash(
        imagePath: 'assets/bd_code.png',
        duration: 5000,
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


