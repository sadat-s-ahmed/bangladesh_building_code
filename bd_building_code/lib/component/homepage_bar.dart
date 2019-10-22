import 'package:bd_building_code/component/upper_curve_clipper.dart';
import 'package:flutter/material.dart';
Color bg_grad = Color.fromRGBO(0, 55, 84,1);
Color bg_grad2 = Color.fromRGBO(8, 88, 149,1);
class HomePageBar extends StatelessWidget {
  final double height;
  final String title;

  const HomePageBar({Key key, this.height, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [bg_grad, bg_grad2],
              ),
            ),
          ),
        ),
        // new Container(
        //   decoration: new BoxDecoration(
        //     gradient: new LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //        Color.fromRGBO(0, 66, 129,1),
        //       Color.fromRGBO(0, 119, 166, 1.0)
        //         ],
        //     ),
        //   ),
        //   height: height,
        // ),
        new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
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
