import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Far_page extends StatefulWidget {
  Far_page({Key key}) : super(key: key);

  _Far_pageState createState() => _Far_pageState();
}

class _Far_pageState extends State<Far_page> {


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:CupertinoNavigationBar(
        middle: Text('FAR Calculator'),
      ),
    );
  }
}