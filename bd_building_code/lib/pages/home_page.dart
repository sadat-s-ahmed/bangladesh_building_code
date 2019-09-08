import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './Conversion_page/conversion_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text('Bangladesh Building Code'),
      // ),
      child: Center(
        child: new Container(
                padding: EdgeInsets.all(32.0),
                margin: EdgeInsets.only(top: 30),
                // decoration: new BoxDecoration(
                //   image: backgroundImage,
                // ),
                alignment: Alignment.center,
                child: Center(
                  child: GridView.count(
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    children: <Widget>[
                      cells('assets/manual.png', 'Guide Book', context),
                      cells('assets/geometry.png', 'FAR Calculator', context),
                      cells('assets/abacus.png', 'Converter Calculator', context),
                      cells('assets/budget.png', 'Section 1', context),
                      cells('assets/budget.png', 'Section 2', context),
                      cells('assets/budget.png', 'Section 3', context),
                    ],
                  ),
                ) ,
        ),
      )
    );
  }
  Widget cells(String assets , String title , BuildContext context ){
    return GestureDetector(
        onTap: (){
         Navigator.of(context).push(
                        CupertinoPageRoute(
                            builder: (context) => ConversionPage()
                            ),
                      );
        },
        child: Center(
        child: Container(
          // decoration: BoxDecoration(
          //   border: BoxBorder
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(assets,
                width: 100.0,
                height: 100.0,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
              Center(
                child: Text(title ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                 ),
                 textAlign: TextAlign.center,  
                )
              )
            ],
            ),
        ),
      ),
    );
  }
  
}
DecorationImage backgroundImage = new DecorationImage(
    image: new ExactAssetImage('assets/Login_bg.jpg'),
    fit: BoxFit.cover,
  );

