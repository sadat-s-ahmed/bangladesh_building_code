import 'package:bd_building_code/component/Contants.dart';
import 'package:bd_building_code/component/bottom_curve_painter.dart';
import 'package:bd_building_code/component/boxfeild.dart';
import 'package:bd_building_code/component/gradient_text.dart';
import 'package:bd_building_code/component/responsive_screen.dart';
import 'package:flutter/material.dart';


Color colorCurve = Color.fromRGBO(58, 58, 58, 1);
Color backgroundColor =Colors.grey.shade200;

class PageForgotPassword extends StatefulWidget {
  @override
  _PageForgotPasswordState createState() => _PageForgotPasswordState();
}

class _PageForgotPasswordState extends State<PageForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  bool isLoading = false;

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Container(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        top: true,
        child: Scaffold(
          appBar: AppBar(
              elevation: 0.0,
              primary: false,
              centerTitle: true,
             backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: colorCurve,
                ),
                onPressed: () => Navigator.pop(context, false),
              )
          ),
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: false,

            body: Stack(children: <Widget>[
              ClipPath(
                  clipper: BottomShapeClipper(),
                  child: Container(
                    color: colorCurve,
                  )),
              Center(
                child: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _forgotGradientText(),
                    SizedBox(height: size.getWidthPx(24)),
                    Header(),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.getWidthPx(16)),
                        child: _emailFeild())
                  ],
                ),
              ),
                ),
              )
            ])),
      ),
    );
  }

  Header() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _passwordIconWidget(),
          SizedBox(height: size.getWidthPx(24)),
          Text(
            "Please fill your details below",
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: 16.0,
                fontStyle: FontStyle.normal),
          ),
        ],
      );

  GradientText _forgotGradientText() {
    return GradientText('Forgot password',
        gradient: LinearGradient(colors: [
           Color.fromRGBO(58, 58, 58,1),
          Color.fromRGBO(58, 58, 58, .4)
        ]),
        style: TextStyle(
            fontFamily: 'Exo2', fontSize: 30, fontWeight: FontWeight.bold));
  }

  CircleAvatar _passwordIconWidget() {
    return CircleAvatar(
      maxRadius: size.getWidthPx(82),
      child: Image.asset("assets/icons/imgforgot.png"),
      backgroundColor: colorCurve,
    );
  }

  BoxField _emailWidget() {
    return BoxField(
      hintText: "Enter email",
      lableText: "Email",
      obscureText: false,
      onSaved: (String val) {},
      validator: validateEmail,
      icon: Icons.email,
      iconColor: colorCurve,
    );
  }

  _emailFeild() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _emailWidget(),
          SizedBox(height: size.getWidthPx(20)),
          _submitButtonWidget(),
        ],
      );

  Container _submitButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(size.getWidthPx(12)),
        child: Text(
          "Submit",
          style: TextStyle(
              fontFamily: 'Exo2', color: Colors.white, fontSize: 20.0),
        ),
        color: colorCurve,
        onPressed: () {
          // Validate Email First
          _validateInputs();
        },
      ),
    );
  }

  String validateEmail(String value) {
    RegExp regExp = RegExp(Constants.PATTERN_EMAIL, caseSensitive: false);

    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter valid email address.";
    }
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      // Go to Dashboard
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
