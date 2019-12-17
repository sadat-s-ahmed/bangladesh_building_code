import 'dart:io';

import 'package:bd_building_code/models/home_card_details.dart';
import 'package:bd_building_code/pages/guidebook_page/Pdfviewer.dart';
import 'package:bd_building_code/pages/guidebook_page/tester.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Color backgroundColor = Colors.grey.shade200;
Color appbarColor = Colors.black;
Color bg_grad = Color.fromRGBO(58, 58,58,1);
Color bg_grad2 = Color.fromRGBO(58, 58, 58,.7);
Color grads = Color.fromRGBO(189 , 195 , 199, 1);
Color grads2 = Color.fromRGBO(44  , 62  , 80, 1);
Color gradinner1 = Color.fromRGBO(255 , 255 , 255, 1);
Color gradinner2 = Color.fromRGBO(255, 255 , 255, .7);
class GuidebookPage extends StatefulWidget {
  @override
  _GuidebookPageState createState() => _GuidebookPageState();
}

class _GuidebookPageState extends State<GuidebookPage> with TickerProviderStateMixin {
  List<HomeCardsDetails> pages = [
      new HomeCardsDetails("BNBC",'assets/home/buildings.png' , TesterPage(title: 'BNBC',url: 'assets/BNBC.pdf',)),
      new HomeCardsDetails(
          "Imarat Nirman Bidhimala", 'assets/home/notebook.png', Pdfviewer(title: 'Imarat Nirman Bidhimala',url: 'assets/imarat_nirman.pdf',)),
      new HomeCardsDetails("Daag", 'assets/home/contract-1.png',Pdfviewer(title:'Daag',url: 'assets/daag.pdf' ))
    ];
  AnimationController cardEntranceController ; 
  List<Animation> ticketAnimation ;
  Animation fabAnimation ;

  
  @override
  void initState() {
    super.initState();
   cardEntranceController =  new AnimationController(
     vsync: this ,
     duration: Duration(milliseconds: 1100)
   );
   ticketAnimation = pages.map((stop){
     int index = pages.indexOf(stop) ;
     double start = index * 0.1;
     double duration = 0.6 ;
     double end = duration + start ;
     return new Tween<double>(begin: 800.0 , end: 0.0 ).animate(
       new CurvedAnimation(
         parent:cardEntranceController,
         curve: new Interval(start, end , curve: Curves.decelerate)
       )
     );
   }).toList();
   fabAnimation = new CurvedAnimation(
     parent: cardEntranceController ,
     curve: Interval(0.1, 1.0 , curve:  Curves.decelerate)
   );

   cardEntranceController.forward();
  }

  @override
  void dispose() {
    cardEntranceController.dispose();
    super.dispose();
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(60.0),
            child: AppBar(
            backgroundColor:appbarColor ,
            elevation: 0.0,
            centerTitle: true,
            title: new Text(
                'Guide Books',
                style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.white
                     ),
              ),
          ),
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
        child: Stack(
        children: <Widget>[
          // HomePageBar(height: 260.0, title: "Bangladesh Building Code"),
          Positioned.fill(
            top: MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              child: Column(
                children: _buildCards().toList(),
              ),
            ),
          )
        ],
      )
      ),
    );
  }

  Iterable<Widget>  _buildCards(){
  return pages.map((page){
    int index = pages.indexOf(page);
    return AnimatedBuilder(
      animation: cardEntranceController,
      child: Card(
          elevation: 8.0,
          borderOnForeground: true,
        
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  stops: [0, 1],
                  colors: [
                    gradinner1,
                    gradinner2
                  ],
                ),
                shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.all(Radius.circular(15.0))
              ),
            child: makeTiles(page),
          ),
        ),
        builder: (context , child ) =>  new Transform.translate(
          offset: Offset(0.0 , ticketAnimation[index].value),
          child: child,
        ),
    );
    
  });
  }

  Widget makeTiles(HomeCardsDetails page) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => page.to),
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(
                    width: 1.0, 
                    color: Colors.black87))),
          child:  Image.asset(
              page.image,
              height: 35,
              width: 35,
              fit: BoxFit.fitWidth,
          )
        ),
        title: Text(
          page.title,
          style: TextStyle(
            color: Colors.black87, 
            fontWeight: FontWeight.bold,
            fontSize: 18.0
            ),
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black87, size: 30.0),
      ),
    );
  }

}







 