import 'package:flutter/material.dart';
import 'package:bd_building_code/component/boxfeild.dart';
import 'package:bd_building_code/component/gradient_text.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:dropdownfield/dropdownfield.dart';


Color backgroundColor = Colors.grey.shade200;
Color bg_grad = Color.fromRGBO(58, 58,58,1);
Color bg_grad2 = Color.fromRGBO(58, 58, 58,.7);


class Far_page extends StatefulWidget {
  Far_page({Key key}) : super(key: key);

  _Far_pageState createState() => _Far_pageState();
}

class _Far_pageState extends State<Far_page> {
  bool _hasList = false;
  bool _autoValidate = false ;
  TextEditingController _areaController = new TextEditingController();
  TextEditingController _lengthController = new TextEditingController();
  TextEditingController _widthController = new TextEditingController();
    String _length , _width;
    int  _area ;
    final _formKey = GlobalKey<FormState>();
    Map<String, dynamic> formData;
  String ptype ;
  String  btype ;  
  List<String> plottype = [
    'Square meters',
    'Katha'
  ];
  List<String> buildings = [
    'Residential Building',
    'Residential Hotel',
    'School/College/University',
    'Institute',
    'Health Complex',
    'Religious/Cultural Building',
    'Office building',
    'Shopping Complex',
    'Industrial Building/Warehouse'
  ];
 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(70.0),
            child: AppBar(
            backgroundColor:bg_grad ,
            elevation: 0.0,
            centerTitle: true,
            title: new Text(
                'FAR Calculator',
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
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                    elevation: 8.0,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    margin: new EdgeInsets.symmetric(
                      horizontal: 10.0,
                       vertical: 15.0
                       ),
                    child: formElement(),
                    
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  _hasList ? 
                    generateList() : 
                    SizedBox(
                    height: 30.0,
                  )
              ],
            ),
          ),
        ),
      ),
    );
    
  }
  Widget formElement(){
    return 
        Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: SingleChildScrollView(
            padding:  const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
               GradientText('Fill Up Your Plot Area Details',
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(58, 58, 58,1),
                  Color.fromRGBO(58, 58, 58, .6)
                ]),
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: 18, 
                  fontWeight: FontWeight.bold)
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
               DropDownField(
                    value: ptype,
                    icon: Icon(Icons.location_city ,color: bg_grad,),
                    required: true,
                    // hintText: 'Chose a Plot Type',
                    labelText: 'Chose a Plot Type',
                    items: plottype,
                    strict: false,
                    setter: (dynamic newValue) {
                      ptype = newValue;
                    }),
                  SizedBox(
                    height: 15.0,
                  ),
                  DropDownField(  
                  value: btype,
                  icon: Icon(Icons.location_city ,color: bg_grad,),
                  required: true,
                  // hintText: 'Building Type',
                  labelText: 'Building Type',
                  items: buildings,
                  strict: false,
                  setter: (dynamic newValue) {
                    // FocusScope.of(context).requestFocus(_areaFocusNode);
                    btype = newValue;
                  }),
                  SizedBox(
                    height: 15.0,
                  ),
                  BoxField(
                    defaultBorderColor: Color.fromRGBO(255, 255, 255, 0),
                    keyboardType:TextInputType.number,
                    controller: _areaController,
                    hintText: "Enter Plot Area",
                    lableText: "Plot Area",
                    obscureText: false,
                    validator: (String val){
                      if(int.parse(val) < 0  ){
                        return 'Area needs to be greater than zero';
                      }
                      return null ;
                    },
                    onSaved: (String val) {
                      _area = int.parse(val);
                    },
                    onFieldSubmitted: (String value) {
                      _formKey.currentState.validate();
                    },
                    icon: Icons.grid_on,
                    iconColor: bg_grad
                  ),
                
                  BoxField(
                    defaultBorderColor: Color.fromRGBO(255, 255, 255, 0),
                    controller: _lengthController,
                    hintText: "Enter Length",
                    lableText: "Length",
                    obscureText: false,
                    validator: (String val){
                      if(int.parse(val) < 0  ){
                        return 'Area needs to be greater than zero';
                      }
                      return null ;
                    },
                    onSaved: (String val) {
                      _length = val;
                    },
                    onFieldSubmitted: (String value) {
                      // FocusScope.of(context).requestFocus(_passFocusNode);
                      _formKey.currentState.validate();
                    },
                    icon: Icons.panorama_vertical,
                    iconColor: bg_grad
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  BoxField(
                    defaultBorderColor: Color.fromRGBO(255, 255, 255, 0),
                    controller: _widthController,
                    hintText: "Enter width",
                    lableText: "Width",
                    obscureText: false,
                    validator: (String val){
                      if(int.parse(val) < 0  ){
                        return 'Area needs to be greater than zero';
                      }
                      return null ;
                    },
                    onSaved: (String val) {
                      _width = val;
                    },
                    onFieldSubmitted: (String value) {
                      // FocusScope.of(context).requestFocus(_passFocusNode);
                       _formKey.currentState.validate();
                    },
                    icon: Icons.panorama_horizontal,
                    iconColor: bg_grad
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  
                  new SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child:RaisedButton(
                      color: bg_grad2,  
                      onPressed: _validateInputs,
                      child: new Text('Generate' ,
                        style:TextStyle(
                          color: Colors.white,
                          fontSize: 22.0
                        ),
                        )
                    ),
                  ),
                
              ],
            ),
          ),
        );
         
    
  }
  void _validateInputs() {
    setState(() {
     _hasList = true; 
    });
  // if (_formKey.currentState.validate()) {
  //   _formKey.currentState.save();
  //   //  _hasList = true;
  // } else {
  //   setState(() {
  //     _autoValidate = true;
  //   });
  // }
}

  generateList(){
    return Card(
        elevation: 8.0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        margin: new EdgeInsets.symmetric(
          horizontal: 10.0,
            vertical: 15.0
            ),
        child: listElement(),
        
      );
  }


  listElement(){
    return SingleChildScrollView(
            padding:  const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                GradientText('Plot Area Details',
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(58, 58, 58,1),
                  Color.fromRGBO(58, 58, 58, .6)
                ]),
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: 35, 
                  fontWeight: FontWeight.bold)
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Road Width',style:TextStyle(fontSize: 20 ,fontWeight:FontWeight.w600),),
                  Text('1285 sqm' ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('FAR',style:TextStyle(fontSize: 20 ,fontWeight:FontWeight.w600),),
                  Text('2.6' ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('MGC',style:TextStyle(fontSize:  20 ,fontWeight:FontWeight.w600),),
                  Text('60' ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Max Building Area',style:TextStyle(fontSize: 20 ,fontWeight:FontWeight.w600),),
                  Text('1285 sqm' ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Max Ground Coverage',style:TextStyle(fontSize:  20 ,fontWeight:FontWeight.w600),),
                  Text('1285 sqm' ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('No. Of Floors',style:TextStyle(fontSize:  20 ,fontWeight:FontWeight.w600),),
                  Text('4' ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Final No. of Floors',style:TextStyle(fontSize: 20 ,fontWeight:FontWeight.w600),),
                  Text('6' ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                )
              ],
            )
    ); 
  }
}