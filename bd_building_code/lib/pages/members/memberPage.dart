import 'dart:convert';

import 'package:bd_building_code/pages/loginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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

class MemberPage extends StatefulWidget {
  

  MemberPage({Key key} ) : super(key: key);
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  
  String tokenn;

  @override
  void initState() { 
    super.initState();
    checkAuth();
  }
  checkAuth() async{
    final tokens = FlutterSecureStorage();
    String token = await tokens.read(key: "token");
    if(token.isEmpty){
      // return to login screen
      Navigator.of(context).push(
              MaterialPageRoute(
              builder: (context) =>LoginPage() )   //Home()
              );
    }
    setState(() {
     tokenn = token ; 
    });
  }


  Future<List<Members>> loadMembers() async{
    List<Members> list ;
    String url = 'http://bnbuildingcode.com/api/members/';

    Map data = {
      'token': tokenn
    };
    print(data);
    var body = json.encode(data);
    http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: body
    );

    final parsed = json.decode(response.body);
    final memberResponse = MemberResponse.fromJson(parsed);
    print(memberResponse.msg);
    if(memberResponse.status == 420){
       Fluttertoast.showToast(
                msg: memberResponse.msg,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white38,
                fontSize: 10.0); 
    return list ;  
          }
    

    if(memberResponse.status == 201){
      final membrs = parsed['memberList'] as List ;
      list = membrs.map<Members>((json) => Members.fromJson(json)).toList();
        // Fluttertoast.showToast(
        //           msg: memberResponse.msg,
        //           toastLength: Toast.LENGTH_LONG,
        //           gravity: ToastGravity.BOTTOM,
        //           timeInSecForIos: 1,
        //           backgroundColor: Colors.black,
        //           textColor: Colors.white10,
        //           fontSize: 10.0); 
      return list ;
    }
    
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
                'Members',
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
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
        child: FutureBuilder(
                future: loadMembers(),
                builder: (context , snapshot){
                  return snapshot.data != null ? 
                    showList(snapshot.data) : 
                    Center(
                      child: CircularProgressIndicator(
                        valueColor:new AlwaysStoppedAnimation<Color>(appbarColor),
                      ),
                    ) ;
                },
            ),
          )
      
      );
  }

  showList(List<Members> list){
    return  ListView.builder(
        itemCount: list.length,
        itemBuilder: (context , index){
          return _ContactListItem(list[index] );
        },
      );
  }


}

class _ContactListItem extends ListTile {

  _ContactListItem(Members contact) :
    super(
      
      title : Text(contact.name),
      subtitle: Text(contact.email),
      leading: CircleAvatar(
        backgroundColor: appbarColor,
        child: Text(contact.name[0],
        style: TextStyle(
            color: Colors.white
        ),

          )
      )
    );

}



class MemberResponse {
  int status ;
  String msg ;


  MemberResponse({this.status , this.msg});

  factory MemberResponse.fromJson(Map<String , dynamic> json){
    return MemberResponse(
      status: json['status'],
      msg: json['msg']
    );
  }

}

class Members{

  String name ;
  String email ;

  Members({this.name , this.email});

  factory Members.fromJson(Map<String , dynamic> json){
    return Members(
      name: json['member_name'],
      email: json['member_email']
    );
  }

}



