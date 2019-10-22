import 'package:bd_building_code/component/homepage_bar.dart';
import 'package:bd_building_code/models/home_card_details.dart';
import 'package:bd_building_code/pages/FAR_page/far_page.dart';
import 'package:bd_building_code/pages/guidebook_page/guidebook_page.dart';
import 'package:bd_building_code/pages/Conversion_page/conversion_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color backgroundColor = Colors.grey.shade200;
Color bg_grad = Color.fromRGBO(58, 58,58,1);
Color bg_grad2 = Color.fromRGBO(58, 58, 58,.7);
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<HomeCardsDetails> pages = [
    new HomeCardsDetails("Guide Book", Icons.book, GuidebookPage()),
    new HomeCardsDetails(
        "Estimation Unit Converter", Icons.apps, ConversionPage()),
    new HomeCardsDetails("FAR Calculator", Icons.blur_linear, Far_page()),
  ];
  AnimationController cardEntranceController;
  List<Animation> ticketAnimation;
  Animation fabAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardEntranceController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    );
    ticketAnimation = pages.map((stop) {
      int index = pages.indexOf(stop);
      double start = index * 0.1;
      double duration = 0.6;
      double end = duration + start;
      return new Tween<double>(begin: 800.0, end: 0.0).animate(
          new CurvedAnimation(
              parent: cardEntranceController,
              curve: new Interval(start, end, curve: Curves.decelerate)));
    }).toList();
    fabAnimation = new CurvedAnimation(
        parent: cardEntranceController,
        curve: Interval(0.7, 1.0, curve: Curves.decelerate));
    cardEntranceController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cardEntranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
            child: AppBar(
            backgroundColor:bg_grad ,
            elevation: 0.0,
            centerTitle: true,
            title: new Text(
                'Bangladesh Building Code',
                style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.white
                     ),
              ),
          ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            Container(
              color: bg_grad2,
              child: new UserAccountsDrawerHeader(
                accountName: new Text("Arefin Chisty"),
                accountEmail: new Text("arefinChisty@gmail.com"),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/lake.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/men/46.jpg")),
              ),
            ),
            new ListTile(
                leading: Icon(Icons.dashboard),
                title: new Text("Guide Books"),
                onTap: () {
                  Navigator.pop(context);
                }),
            new ListTile(
                leading:Icon(Icons.apps),
                title: new Text("FAR Calculator"),
                onTap: () {
                  Navigator.pop(context);
                }),
            new ListTile(
                leading: Icon(Icons.settings),
                title: new Text("Estimation Unit Calculator"),
                onTap: () {
                  Navigator.pop(context);
                }),
            new Divider(),
            new ListTile(
                leading: Icon(Icons.info),
                title: new Text("About"),
                onTap: () {
                  Navigator.pop(context);
                }),
            new ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: Stack(
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
      ),
    );
  }

  Iterable<Widget> _buildCards() {
    return pages.map((page) {
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
              color: backgroundColor,
              borderRadius: new BorderRadius.all(Radius.circular(15.0))
              ),
            child: makeTiles(page),
          ),
        ),
        builder: (context, child) => new Transform.translate(
          offset: Offset(0.0, ticketAnimation[index].value),
          child: child,
        ),
      );
    });
  }

  Widget makeTiles(HomeCardsDetails page) {
    return GestureDetector(
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
          child: Icon(
              page.iconData,
             color: Colors.black87,
             size: 35.0,
             ),
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
