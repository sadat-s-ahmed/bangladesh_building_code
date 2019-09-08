import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Bangladesh Building Code'),
      ),
      child: new Container(
              padding: EdgeInsets.all(32.0),
              // decoration: new BoxDecoration(
              //   image: backgroundImage,
              // ),
              alignment: Alignment.center,
              child: Center(
                child: GridView.count(
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: <Widget>[
                    cells('assets/bd_code.png', 'Hello'),
                    cells('assets/bd_code.png', 'Hello'),
                    cells('assets/bd_code.png', 'Hello'),
                    cells('assets/bd_code.png', 'Hello'),
                    cells('assets/bd_code.png', 'Hello'),
                    cells('assets/bd_code.png', 'Hello'),
                  ],
                ),
              ) ,
      )
    );
  }
  Widget cells(String assets , String title ){
    return Center(
      child: Container(
        // decoration: BoxDecoration(
        //   border: BoxBorder
        // ),
        child: Column(
          children: <Widget>[
            Image.asset(assets,
              width: 100.0,
              height: 100.0,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            Text(title)
          ],
          ),
      ),
    );
  }
  
}
DecorationImage backgroundImage = new DecorationImage(
    image: new ExactAssetImage('assets/Login_bg.jpg'),
    fit: BoxFit.cover,
  );

