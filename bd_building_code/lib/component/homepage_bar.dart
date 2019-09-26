import 'package:flutter/material.dart';

class HomePageBar extends StatelessWidget {
  final double height;
  final String title;

  const HomePageBar({Key key, this.height, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
               Color.fromRGBO(0, 66, 129,1),
              Color.fromRGBO(0, 119, 166, 1.0)
                ],
            ),
          ),
          height: height,
        ),
        new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          actions: <Widget>[

          ],
          title: new Text(
            title,
            style: TextStyle(
                 fontWeight: FontWeight.bold,
                 color: Colors.white
                 ),
          ),
        ),
      ],
    );
  }
}
