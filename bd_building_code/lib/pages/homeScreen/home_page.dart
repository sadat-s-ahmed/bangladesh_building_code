
import 'package:bd_building_code/models/home_card_details.dart';
import 'package:bd_building_code/pages/FAR_page/far_page.dart';
import 'package:bd_building_code/pages/guidebook_page/guidebook_page.dart';
import 'package:bd_building_code/pages/Conversion_page/conversion_page.dart';
import 'package:bd_building_code/pages/about/about_page.dart';
import 'package:bd_building_code/pages/loginScreen/loginScreen.dart' as prefix0;
import 'package:bd_building_code/pages/loginScreen/loginScreen.dart';
import 'package:bd_building_code/pages/members/memberPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color backgroundColor = Colors.grey.shade200;
Color appbarColor = Colors.black;
Color bg_grad = Color.fromRGBO(58, 58,58,1);
Color bg_grad2 = Color.fromRGBO(58, 58, 58,.7);
Color grads = Color.fromRGBO(189 , 195 , 199, 1);
Color grads2 = Color.fromRGBO(44  , 62  , 80, 1);
Color gradinner1 = Color.fromRGBO(142 , 158 , 171, 1);
Color gradinner2 = Color.fromRGBO(238, 242 , 243, 1);



class HomePage extends StatefulWidget {
  final tokenn ; 
  final name   ;
  final email ;
  const HomePage({Key key, 
                  this.tokenn , 
                  this.name , 
                  this.email} ) : 
                  super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String _token ;

  List<HomeCardsDetails> pages = [
    new HomeCardsDetails("Guide Book",'assets/home/catalogue.png' , GuidebookPage()),
    new HomeCardsDetails(
        "Estimation Unit Converter", 'assets/home/calculator.png', ConversionPage()),
    new HomeCardsDetails("FAR Calculator", 'assets/home/calculation.png', Far_page()),
    new HomeCardsDetails("Member", 'assets/home/science.png', MemberPage()),
    
    new HomeCardsDetails("About", 'assets/home/architecture-and-city.png', AboutPage()),
  ];


  @override
  void initState() { 
    super.initState();
    getToken();
  }
  
  void getToken() async {
    final tokens = FlutterSecureStorage();
    String token = await tokens.read(key: "token");
    print(token);
    if(token == '' ){
      // return to login screen
      Navigator.of(context).push(
              MaterialPageRoute(
              builder: (context) =>LoginPage() )   //Home()
              );
    }else{
      setState(() {
       _token = token;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
            child: AppBar(
            backgroundColor:appbarColor ,
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
              
              color:Colors.white,
              child: new UserAccountsDrawerHeader(
                accountName: new Text(widget.name),
                accountEmail: new Text(widget.email),
                decoration: BoxDecoration(
                  color:  appbarColor,
                ),
                // decoration: new BoxDecoration(
                //   image: new DecorationImage(
                //     image: new ExactAssetImage('assets/images/lake.jpeg'),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                // currentAccountPicture: CircleAvatar(
                //     backgroundImage: NetworkImage(
                //         "https://randomuser.me/api/portraits/men/46.jpg")),
              ),
            ),
            new ListTile(
                leading: Icon(Icons.verified_user),
                title: new Text("Profile"),
                onTap: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GuidebookPage()),
                  );
                }),
            new ListTile(
                leading:Icon(Icons.bug_report),
                title: new Text("Report Issue"),
                onTap: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Far_page()),
                  );
                }),
            new ListTile(
                leading: Icon(Icons.settings),
                title: new Text("Settings"),
                onTap: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ConversionPage()),
                  );
                }),
            new Divider(),
            new ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text("Logout"),
                onTap: () async{
                  final authCodeStorage = new FlutterSecureStorage();
                  await authCodeStorage.write(key: "token", value: '');
                  await authCodeStorage.write(key: "name", value: '');
                  await authCodeStorage.write(key: "email", value: '');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) =>LoginPage() 
                    )   //Home()
                    );
                }),
          ],
        ),
      ),
      body:Padding(
        padding: EdgeInsets.all(10.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2 ,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10
                      ),
          itemCount: pages.length,            
          itemBuilder: (BuildContext context, int index) {            
              return getStructuredGridCell(pages[index]);
            }
  
        ),
      
      
      )
      );
  }

  Widget getStructuredGridCell(HomeCardsDetails page) {
    return InkWell(
          onTap:(){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => page.to),
            );
          } ,
          child: new Card(

          color: Colors.grey[50],
          elevation: 1.2,
          child: Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Image.asset(
                    page.image,
                    height: 60,
                    width: 35,
                    fit: BoxFit.contain,
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text(
                      page.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87, 
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                        ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }


}

      // Stack(
      //    fit: StackFit.expand,
      //   children: <Widget>[
      //     // HomePageBar(height: 260.0, title: "Bangladesh Building Code"),
      //     Container(
      //         decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.topCenter,
      //             end: Alignment.bottomCenter,
      //             stops: [0, 1],
      //             colors: [
      //               grads,
      //               grads2
      //             ],
      //           ),
      //         ),
      //         child:SingleChildScrollView(
      //               child: Column(
      //                 children: _buildCards().toList(),
      //               ),
      //             ),
      //         )
          
      //   ],
      // ),
  //   )
  //   );
  // }

  // Iterable<Widget> _buildCards() {
  //   return pages.map((page) {
  //     int index = pages.indexOf(page);
  //     return AnimatedBuilder(
  //       animation: cardEntranceController,
  //       child: Card(
  //         elevation: 8.0,
  //         borderOnForeground: true,
        
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //         margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //                 begin: Alignment.topCenter,
  //                 end: Alignment.bottomCenter,
  //                 stops: [0, 1],
  //                 colors: [
  //                   gradinner1,
  //                   gradinner2
  //                 ],
  //               ),
  //               shape: BoxShape.rectangle,
  //             borderRadius: new BorderRadius.all(Radius.circular(15.0))
  //             ),
  //           child: makeTiles(page),
  //         ),
  //       ),
  //       builder: (context, child) => new Transform.translate(
  //         offset: Offset(0.0, ticketAnimation[index].value),
  //         child: child,
  //       ),
  //     );
  //   });
  // }

  // Widget makeTiles(HomeCardsDetails page) {
  //   return GestureDetector(
  //     onTap: (){
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => page.to),
        // );
  //     },
  //     child: ListTile(
  //       contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        // leading: Container(
        //   padding: EdgeInsets.only(right: 12.0),
        //   decoration: new BoxDecoration(
        //       border: new Border(
        //           right: new BorderSide(
        //             width: 1.0, 
        //             color: Colors.black87))),
        //   child:  Image.asset(
        //       pages.image,
        //       height: 35,
        //       width: 35,
        //       fit: BoxFit.fitWidth,
        //   )
          
          
          // Icon(
          //     page.iconData,
          //    color: Colors.black87,
          //    size: 35.0,
          //    ),
        // ),
        // title: Text(
        //   page.title,
        //   style: TextStyle(
        //     color: Colors.black87, 
        //     fontWeight: FontWeight.bold,
        //     fontSize: 18.0
        //     ),
        // ),
  //       trailing:
  //           Icon(Icons.keyboard_arrow_right, color: Colors.black87, size: 30.0),
  //     ),
  //   );
  // }

