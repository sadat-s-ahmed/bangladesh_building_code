import 'dart:convert';

import 'package:bd_building_code/component/bottom_curve_painter.dart';
import 'package:bd_building_code/component/boxfeild.dart';
import 'package:bd_building_code/component/gradient_text.dart';
import 'package:bd_building_code/component/responsive_screen.dart';
import 'package:bd_building_code/pages/loginScreen/loginScreen.dart' as prefix0;
import 'package:bd_building_code/pages/loginScreen/loginScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color colorCurve = Color.fromRGBO(58, 58, 58, 1);
Color backgroundColor =Colors.grey.shade200;
Color grads = Color.fromRGBO(189 , 195 , 199, 1);
Color grads2 = Color.fromRGBO(44  , 62  , 80, 1);
Color gradinner1 = Color.fromRGBO(142 , 158 , 171, 1);
Color gradinner2 = Color.fromRGBO(238, 242 , 243, 1);

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool loading = false ;
  bool _autovalidate = false ;
  RegisterResponse _registerResponse ;
  TextEditingController _nameController =  TextEditingController();
  TextEditingController _emailController =  TextEditingController();
  TextEditingController _passwordController =  TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String _name ,
   _email,
   _password,
   _confirmPassword;
   bool isSwitched = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
        backgroundColor:backgroundColor ,
        resizeToAvoidBottomInset: true,
        body:ListView(
           
            children: <Widget>[
              Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                   begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                  colors: [
                    grads,
                    grads2
                  ],
                ),
              ),
              child:new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  registerThings(),
                ],
              ) ,
              ),

              
            ],
          )
        
        
        
    //      Stack(children: <Widget>[
    //     ClipPath(
    //     clipper: BottomShapeClipper(),
    //     child: Container(
    //       color: colorCurve,
    //     )),
    //       SingleChildScrollView(
    //     child: SafeArea(
    //       top: true,
    //       bottom: false,
    //       child: Container(
    //         margin: EdgeInsets.symmetric(
    //             horizontal: size.getWidthPx(20), vertical: size.getWidthPx(20)),
    //         child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Row(
    //                 children: <Widget>[
    //                   IconButton(
    //                     icon: Icon(Icons.arrow_back,color: colorCurve,),
    //                     onPressed: () => Navigator.pop(context, false),
    //                   ),
    //                   SizedBox(width: size.getWidthPx(10)),
    //                   _signUpGradientText(),
    //                 ],
    //               ),
    //               SizedBox(height: size.getWidthPx(10)),
    //               _textAccount(),
    //               SizedBox(height: size.getWidthPx(30)),
    //               registerFields()
    //             ]),
    //       ),
    //     ),
    //   )
    // ])
    );
  }

  registerThings(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
      padding: const EdgeInsets.all(15.0),
      decoration: new BoxDecoration(
        gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                  colors: [
                    gradinner1,
                    gradinner2
                  ],
                ),
        //you can get rid of below line also
        borderRadius: new BorderRadius.circular(10.0),
        //below line is for rectangular shape
        shape: BoxShape.rectangle,
        //you can change opacity with color here(I used black) for rect
        // color: Colors.black.withOpacity(0.5),
        //I added some shadow, but you can remove boxShadow also.
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.white30,
            blurRadius: 5.0,
            offset: new Offset(2.0, 2.0),
          ),
        ],
      ),
      child: SingleChildScrollView(
              child: new Column(
          children: <Widget>[
              SingleChildScrollView(
                child: SafeArea(
                  top: true,
                  bottom: false,
                  child: Container(
                    // margin: EdgeInsets.symmetric(
                    //     horizontal: size.getWidthPx(20), vertical: size.getWidthPx(20)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          
                          _signUpGradientText(),
                            
                          
                          SizedBox(height: size.getWidthPx(10)),
                          _textAccount(),
                          SizedBox(height: size.getWidthPx(30)),
                          registerFields()
                        ]),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  
  }


  RichText _textAccount() {
    return RichText(
      text: TextSpan(
          text: "Hae you registed already? ",
          children: [
            TextSpan(
              style: TextStyle(
                color: Color.fromRGBO(58, 58,58, .6)),
              text: 'Login here',
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pop(context, false),
            )
          ],
          style: TextStyle(fontFamily: 'Exo2',color: Colors.black87, fontSize: 16)),
    );
  }

  GradientText _signUpGradientText() {
    return GradientText('Register',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(58, 58, 58,1),
          Color.fromRGBO(58, 58, 58, .4)
        ]),
        style: TextStyle(fontFamily: 'Exo2',fontSize: 36, fontWeight: FontWeight.bold));
  }

   _nameWidget() {
        return Container(
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        color: Colors.grey.shade100,
        border:  Border.all(color:Colors.grey.shade400, width: 1.0),
        borderRadius:  BorderRadius.circular(8.0)),
      child: TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black38),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black38,
            size: 22,
          ),
          border: InputBorder.none,
            labelText:"Name ", 
            fillColor: Colors.white
        ) ,
        validator: (var val){
          
          if( val.isEmpty){
            return 'Email cannot be Empty';
          }
          if(val.length < 5){
            return 'Name must have minimum 6 characters';
          }
          return null ;
          
        },
        onChanged: (var val ){
          _name = val;
        },
        onSaved: (var val){
          _name = val ;
        },
      ),
    ) ;
  }
  
   _emailWidget() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        color: Colors.grey.shade100,
        border:  Border.all(color:Colors.grey.shade400, width: 1.0),
        borderRadius:  BorderRadius.circular(8.0)),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black38),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black38,
            size: 22,
          ),
          border: InputBorder.none,
            labelText:"Email Address", 
            fillColor: Colors.white
        ) ,
        validator: (var val){
          
          if( val.isEmpty){
            return 'Email cannot be Empty';
          }
          if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
            return 'Enter a Valid email address' ;
          }
          return null ;
          
        },
        onChanged: (var val ){
          _email = val;
        },
        onSaved: (var val){
          _email = val ;
        },
      ),
    ) ;
    
  }

   _passwordWidget() {
    return Container(
      margin: EdgeInsets.only(top: 0 ),
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        color: Colors.grey.shade100,
        border:  Border.all(color:Colors.grey.shade400, width: 1.0),
        borderRadius:  BorderRadius.circular(8.0)),
      child: TextFormField(
        controller: _passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black38),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.black38,
            size: 22,
          ),
          border: InputBorder.none,
            labelText:"Enter Password", 
            fillColor: Colors.white
        ) ,
        validator: (var val){
          
          if( val.isEmpty){
            return 'Password cannot be empty';
          }
          if(val.length < 8 ){
            return 'Password needs to be minimum 8 characters ';
          }

          return null ;
          
        },
        onChanged: (var val ){
          _password = val;
        },
        onSaved: (var val){
          _password = val ;
        },
      ),
    ) ;
  }

   _confirmPasswordWidget() {
    return Container(
      margin: EdgeInsets.only(top: 0 ),
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        color: Colors.grey.shade100,
        border:  Border.all(color:Colors.grey.shade400, width: 1.0),
        borderRadius:  BorderRadius.circular(8.0)),
      child: TextFormField(
        controller: _confirmPasswordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black38),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.black38,
            size: 22,
          ),
          border: InputBorder.none,
            labelText:"Confirm Password", 
            fillColor: Colors.white
        ) ,
        validator: (var val){
          
          if( val.isEmpty){
            return 'Password cannot be empty';
          }
          if(val.length < 8 ){
            return 'Password needs to be minimum 8 characters ';
          }
          if(val != _password){
            return 'Password must match';
          }

          return null ;
          
        },
        onChanged: (var val ){
          _confirmPassword = val;
        },
        onSaved: (var val){
          _confirmPassword = val ;
        },
      ),
    ) ;
  }
  _visibilitySwitch(){
    return Container(
    margin: EdgeInsets.only(top: 0 ),
    padding: EdgeInsets.all(5),
    alignment: Alignment.center,
    decoration:  BoxDecoration(
      color: Colors.grey.shade100,
      border:  Border.all(color:Colors.grey.shade400, width: 1.0),
      borderRadius:  BorderRadius.circular(8.0)
      ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Public'),
        Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
        activeTrackColor: Colors.black87, 
        activeColor: Colors.black
        ),
      ],
    ),
    );
  }

 


  Container _signUpButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(size.getWidthPx(12)),
        child: loading ? 
          Center(
              child: CircularProgressIndicator(
                valueColor:new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ) :
        Text(
          loading ? Center(child: CircularProgressIndicator(),)  : "Sign Up",
          style: TextStyle(fontFamily: 'Exo2',color: Colors.white, fontSize: 20.0),
        ),
        color: colorCurve,
        onPressed: () async{
          // Going to DashBoard
          setState(() {
            loading = true; 
          });
        
          if (_formKey.currentState.validate()) {
           _formKey.currentState.save();
            Map data = {
              'name': _name,
              'email': _email ,
              'password': _password ,
              'publicVisible': isSwitched
            };
          var body = json.encode(data);
          print(body);
          String url = "http://bnbuildingcode.com/api/register/";
          http.Response response = await http.post(url,
              headers: {
                'Content-Type': 'application/json'
              },
              body: body
          );
          print(response.body);
          final parsed = json.decode(response.body);
          _registerResponse = RegisterResponse.fromJson(parsed );
          print(_registerResponse);
          if(_registerResponse.status == 420){
            Fluttertoast.showToast(
                msg: _registerResponse.msg,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.redAccent,
                textColor: Colors.black,
                fontSize: 10.0); 
            setState(() {
             loading = false ; 
            });    
          }

          if(_registerResponse.status == 201){
            Fluttertoast.showToast(
                msg: _registerResponse.msg,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 10.0);  
            setState(() {
             loading = false ; 
            });
            Navigator.of(context).push(
              MaterialPageRoute(
              builder: (context) => LoginPage()   //Home()
              ));

            
            }
          } else{
            setState(() {
            loading = false ;
            _autovalidate = true;
          });
          }
        },
      ),
    );
  }

  GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: size.getWidthPx(20),
        backgroundColor: Colors.white,
        child: Image.asset(assetIcon),
      ),
    );
  }

  registerFields() => Container(
        child: Form(
            key: _formKey,
            autovalidate: _autovalidate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _nameWidget(),
                SizedBox(height: size.getWidthPx(8)),
                _emailWidget(),
                SizedBox(height: size.getWidthPx(8)),
                _passwordWidget(),
                SizedBox(height: size.getWidthPx(8)),
                _confirmPasswordWidget(),
                SizedBox(height: size.getWidthPx(8)),
                _visibilitySwitch(),
                SizedBox(height: size.getWidthPx(8)),
                _signUpButtonWidget(),
              ],
            )),
      );
}


class RegisterResponse {
  int status ;
  String msg ;

  RegisterResponse({this.status , this.msg  });

  factory RegisterResponse.fromJson(Map<String , dynamic> json){
    return RegisterResponse(
      status: json['status'],
      msg: json['msg'] 
    );
  }

}