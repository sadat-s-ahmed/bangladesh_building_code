import 'package:bd_building_code/component/DecimalTextInputFormatter.dart';
import 'package:flutter/material.dart';
import 'package:bd_building_code/component/boxfeild.dart';
import 'package:bd_building_code/component/gradient_text.dart';
import 'package:flutter/services.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';


Color backgroundColor = Colors.grey.shade200;
Color bg_grad = Color.fromRGBO(58, 58,58,1);
Color bg_grad2 = Color.fromRGBO(58, 58, 58,.7);
Color appbarColor = Colors.black;

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
    int _length , _width;
    int  _area ;
    final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData;
  var ptype ;
  var  btype ;  
  List plottype = [
    {
      "display": "Square meters",
      "value": 1,
    },
    {
      "display": "Katha",
      "value": 2,
    }
  ];
  List buildings = [
    {
      "display": "Residential Building",
      "value": 1,
    },
    {
      "display": "Residential Hotel",
      "value": 2,
    },
    {
      "display": "School/College/University",
      "value": 3,
    },
    {
      "display": "Institute",
      "value": 4,
    },
    {
      "display": "Health Complex",
      "value": 5,
    },
    {
      "display": "Religious/Cultural Building",
      "value": 6,
    },
    {
      "display": "Office building",
      "value": 7,
    },
    {
      "display": "Shopping Complex",
      "value": 8,
    },
    {
      "display": "Industrial Building/Warehouse",
      "value": 9,
    }
  ];
  

  @override
  void initState() {
    ptype = 1 ;
    btype = 1 ;  
    _area = 0 ;
    _length = 0 ;
    _width= 0 ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(70.0),
            child: AppBar(
            backgroundColor:appbarColor ,
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
          autovalidate: true,
          child: SingleChildScrollView(
            padding:  const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
               GradientText('Fill Up Your Plot Area Details',
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(58, 58, 58,1),
                  Color.fromRGBO(58, 58, 58, .6)
                ]),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Exo2',
                  fontSize: 18, 
                  fontWeight: FontWeight.bold)
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      
                      required: true,
                      titleText: 'Plot Type',
                      hintText: 'Please choose one',
                      value: ptype,
                      onSaved: (value) {
                        setState(() {
                          ptype = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          ptype = value;
                        });
                      },
                      dataSource:plottype,
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: DropDownFormField(
                      required: true ,
                      titleText: 'Building Type',
                      hintText: 'Please choose a Type of Building',
                      value: btype,
                      onSaved: (value) {
                        setState(() {
                          btype = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          btype = value;
                        });
                      },
                      dataSource:buildings,
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _areaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                        DecimalTextInputFormatter(decimalRange: 2) ,
                         BlacklistingTextInputFormatter(RegExp("[-,]"))
                    ],
                    decoration: InputDecoration(
                        labelText:"Plot Area", 
                        hintText: "Enter Plot Area",
                        icon: Icon(Icons.grid_on)
                    ) ,
                    validator: (var val){
                      
                      if( val.isEmpty){
                        return 'Area cannot be Zero';
                      }
                      var v =  int.parse(val);
                      if( v > 1 ){
                        return 'THis is greater';
                      }
                      return null ;
                    },
                    onChanged: (var val ){
                      _area = int.parse(val);
                    },
                    onSaved: (var val){
                      _area = int.parse(val);
                    },
                  ),
                  TextFormField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                        DecimalTextInputFormatter(decimalRange: 2),
                         BlacklistingTextInputFormatter(RegExp("[-,]"))
                    ],
                    decoration: InputDecoration(
                        labelText:"Length", 
                        hintText: "Enter Length",
                        icon: Icon(Icons.panorama_vertical)
                    ) ,
                    validator: (var val){
                      if(val.isEmpty){
                        return 'Length cannot be Zero';
                      }
                      var v =  int.parse(val);
                      
                      return null ;
                    },
                    onChanged: (var val ){
                      _length = int.parse(val);
                    },
                    onSaved: (var val){
                      _length = int.parse(val);
                    },
                  ),  
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _widthController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                        DecimalTextInputFormatter(decimalRange: 2),
                        BlacklistingTextInputFormatter(RegExp("[-,]"))
                    ],
                    decoration: InputDecoration(
                        labelText:"Width", 
                        hintText: "Enter Width",
                        icon: Icon(Icons.panorama_horizontal)
                    ) ,
                    validator: (val){
                      if( val.isEmpty ){
                        return 'Width cannot be Zero';
                      }
                      if(!val.isEmpty){
                        var v =int.parse(val);
                        if(v > btype ){
                          return 'Just Checking';
                        }else{
                          return null ;
                        }
                      }
                    },
                    onChanged: (val ){
                      _width = int.parse(val);
                    },
                    onSaved: ( val){
                      _width = int.parse(val);
                    },
                  ),
                  
                  SizedBox(
                    height: 15.0,
                  ),
                  new SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child:RaisedButton(
                      color: appbarColor,  
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