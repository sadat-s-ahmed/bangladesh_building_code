import 'package:bd_building_code/component/bottom_curve_painter.dart';
import 'package:bd_building_code/component/boxfeild.dart';
import 'package:bd_building_code/component/gradient_text.dart';
import 'package:bd_building_code/component/responsive_screen.dart';
import 'package:bd_building_code/pages/forgotpasswordPage.dart/forgot_password_page.dart';
import 'package:bd_building_code/pages/homeScreen/home_page.dart';
import 'package:bd_building_code/pages/registerpage.dart/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color colorCurve = Color.fromRGBO(0, 66, 129, 0.8);
Color backgroundColor =Colors.grey.shade200;

// Color colorCurveSecondary = Color.fromRGBO(97, 10, 155, 0.6);
// Color backgroundColor =Colors.grey.shade200;
// Color textPrimaryColor =Colors.black87;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _passFocusNode = new FocusNode();
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery
        .of(context)
        .size);

    return Scaffold(
        backgroundColor:backgroundColor,
        resizeToAvoidBottomInset: true,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
              statusBarColor: backgroundColor,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor:backgroundColor
              ),

          child: Container(
            color: Colors.white,
            child: SafeArea(
              top: true,
              bottom: false,
              child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[


              ClipPath(
              clipper: BottomShapeClipper(),
              child: Container(
                  color: colorCurve,
                  )),
                    SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.getWidthPx(20),
                        vertical: size.getWidthPx(20)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          _loginGradientText(), // text
                          SizedBox(height: size.getWidthPx(10)),
                          _textAccount(),
                          SizedBox(height: size.getWidthPx(30)),
                          loginFields()
                        ]),
                  ),
                )
              ]),
            ),
          ),
        ));
  }

  RichText _textAccount() {
    return RichText(
      text: TextSpan(
          text: "Don't have an account? ",
          children: [
            TextSpan(
              style: TextStyle(color: Color.fromRGBO(0, 119, 166, 1)),
              text: 'Create your account.',
              recognizer: TapGestureRecognizer()
                ..onTap = () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
            )
          ],
          style: TextStyle(
            color: Colors.black87, 
            fontSize: 14, 
            fontFamily: 'Exo2')
            ),
    );
  }

  GradientText _loginGradientText() {
    return GradientText('Login',
        gradient: LinearGradient(colors: [
          Color.fromRGBO(0, 66, 129,1),
          Color.fromRGBO(0, 119, 166, 1.0)
        ]),
        style: TextStyle(fontFamily: 'Exo2',fontSize: 36, fontWeight: FontWeight.bold));
  }

  BoxField _emailWidget() {
    return BoxField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        hintText: "Enter email",
        lableText: "Email",
        obscureText: false,
        onSaved: (String val) {
          _email = val;
        },
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passFocusNode);
        },
        icon: Icons.email,
        iconColor: colorCurve);
  }

  BoxField _passwordWidget() {
    return BoxField(
        controller: _passwordController,
        focusNode: _passFocusNode,
        hintText: "Enter Password",
        lableText: "Password",
        obscureText: true,
        icon: Icons.lock_outline,
        onSaved: (String val) {
          _password = val;
        },
        iconColor: colorCurve);
  }

  Container _loginButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)
          ),
      width: size.getWidthPx(200),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)
            ),
        padding: EdgeInsets.all(size.getWidthPx(12)),
        child: Text(
          "LOGIN",
          style: TextStyle(
            fontFamily: 'Exo2',
            color: Colors.white, 
            fontSize: 20.0),
        ),
        color: colorCurve,
        onPressed: () {
          // Going to DashBoard
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        },
      ),
    );
  }



  GestureDetector socialCircleAvatar(String assetIcon,VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(

        maxRadius: size.getWidthPx(24),
        backgroundColor: Colors.transparent,
        child: Image.asset(assetIcon),
      ),
    );
  }


  loginFields() =>
      Container(
        child: Form(
            key: _formKey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _emailWidget(),
                SizedBox(height: size.getWidthPx(8)),
                _passwordWidget(),
                GestureDetector(
                    onTap: () {
                      //Navigate to Forgot Password Screen...
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PageForgotPassword()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: size.getWidthPx(24)),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 119, 166,1.0),
                                fontFamily: 'Exo2',
                                fontSize: 16.0)
                                )
                                )
,
                    )),
                SizedBox(height: size.getWidthPx(8)),
                _loginButtonWidget(),
                SizedBox(height: size.getWidthPx(28)),

              ],
            )),
      );
}



