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
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData;
   double _length;
   double  _width;
  double  _area ;
  int ptype ;
  int  btype ;  
  double _RW ;
  double _FAR ;
  double _MGC ;
  double _MBA ;
  double _MaxGC ;
  double _floors ;
  double final_floors ;
  double _Existing_land_Area ; 
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
      "display": "Primary School/ Kindergarden ",
      "value": 4,
    },
    {
      "display": "Institute",
      "value": 5,
    },
    {
      "display": "Health Complex",
      "value": 6,
    },
    {
      "display": "Religious/Cultural Building",
      "value": 7,
    },
    {
      "display": "Office building",
      "value": 8,
    },
    {
      "display": "Shopping Complex",
      "value": 9,
    },
    {
      "display": "Industrial Building/Warehouse",
      "value": 10,
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
                      validator: (val){
                       if( val == null ){
                        return 'Please Select an Option';
                      }
                      return null;
                      },
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
                      validator: (val){
                       if( val == null ){
                        return 'Please Select an Option';
                      }
                      return null;
                      },
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
          
                      return null ;
                    },
                    onChanged: (var val ){
                      _area = double.parse(val ) ;
                    },
                    onSaved: (var val){
                      _area = double.parse(val ) ;
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
              
                      
                      return null ;
                    },
                    onChanged: (var val ){
                      _length = double.parse(val ) ;
                    },
                    onSaved: (var val){
                      _length =double.parse(val ) ;
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
                    },
                    onChanged: (val ){
                      _width = double.parse(val ) ;
                    },
                    onSaved: ( val){
                      _width = double.parse(val ) ;
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
    
    
  if (_formKey.currentState.validate()) {
    _formKey.currentState.save();
      generateValues();
      setState(() {
     _hasList = true; 
    });
    //  _hasList = true;
  } else {
    setState(() {
      _autoValidate = true;
    });
  }
}

  generateValues(){
  
    
    
    if(btype == 1 ){
      // residential building
      getResidentialBuilding();
    }else if(btype == 2 ){
      //residential hotel
      getResidentialHotel();
    } else if( btype == 3){
      getSchool();
    } else if (btype == 4 ){
      getkindergarden();
    } else if (btype == 5 ){
      getInstitute();
    } else if (btype == 6){
      getHealth();
    }else if (btype == 7 ){
      getReligious();
    }else if(btype == 8 ){
      getOfficeBuilding();
    }else if (btype == 9 ){
      getShoppingComplex();
    }else if(btype == 10 ){
      getIbuilding();
    }

    setState(() {
      _Existing_land_Area = _length   * _width ;
      _MBA = _Existing_land_Area *_FAR ; 
      _MaxGC = _Existing_land_Area *_MGC  ;
      _floors = _MBA / _MGC  ;
      final_floors = 1 + _floors ;
    });
    print(_Existing_land_Area );
     print(_MBA);
     print(_MaxGC);
     print(_floors);
     print(final_floors);
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
                  Text( _RW.toStringAsFixed(1),style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('FAR',style:TextStyle(fontSize: 20 ,fontWeight:FontWeight.w600),),
                  Text( _FAR.toStringAsFixed(1),style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('MGC',style:TextStyle(fontSize:  20 ,fontWeight:FontWeight.w600),),
                  Text( _MGC.toStringAsFixed(1),style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Existing Land Area',style:TextStyle(fontSize: 20 ,fontWeight:FontWeight.w600),),
                  Text(  _Existing_land_Area.toStringAsFixed(1) ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Max Building Area',style:TextStyle(fontSize: 20 ,fontWeight:FontWeight.w600),),
                  Text(  _MBA.toStringAsFixed(1) ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Max Ground Coverage',style:TextStyle(fontSize:  20 ,fontWeight:FontWeight.w600),),
                  Text( _MaxGC.toStringAsFixed(1),style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('No. Of Floors',style:TextStyle(fontSize:  20 ,fontWeight:FontWeight.w600),),
                  Text(  _floors.toStringAsFixed(1) ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                ),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Final No. of Floors',style:TextStyle(fontSize: 20 ,fontWeight:FontWeight.w600),),
                  Text(final_floors.toStringAsFixed(1) ,style:TextStyle(fontSize: 18 ,fontWeight:FontWeight.w700),)
                ],
              ),
              SizedBox(
                  height: 15.0,
                )
              ],
            )
    ); 
  }


getIbuilding(){
  if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 6 ;
          _FAR = 2.0;
          _MGC = 65.0;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
          _RW = 6 ;
          _FAR = 2.0;
          _MGC = 65.0;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 6 ;
          _FAR = 2.25;
          _MGC = 65.0;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
          _RW = 6 ;
          _FAR = 2.25;
          _MGC = 65.0;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
         _RW = 6 ;
          _FAR = 2.50;
          _MGC = 65.0;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
           _RW = 6 ;
          _FAR = 2.50;
          _MGC = 65.0;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
           _RW = 9 ;
          _FAR = 2.75;
          _MGC = 65.0;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
           _RW = 9 ;
          _FAR = 2.75;
          _MGC = 65.0;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
           _RW = 9 ;
          _FAR = 2.75;
          _MGC = 65.0;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
          _RW = 9 ;
          _FAR = 3.0;
          _MGC = 62.5;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
          _RW = 9 ;
          _FAR = 3.25;
          _MGC = 62.5;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
          _RW = 9 ;
          _FAR = 3.5;
          _MGC = 60.0;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
          _RW = 9 ;
          _FAR = 3.75;
          _MGC = 60.0;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
          _RW = 9 ;
          _FAR = 4.00;
          _MGC = 60.0;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
          _RW = 12 ;
          _FAR = 4.25;
          _MGC = 60.0;
        });
      }
}

getShoppingComplex(){
  if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 6 ;
          _FAR = 2.25;
          _MGC = 65.0;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
          _RW = 6 ;
          _FAR = 2.50;
          _MGC = 62.5;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 6 ;
          _FAR = 2.50;
          _MGC = 62.5;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
          _RW = 6 ;
          _FAR = 3.0;
          _MGC = 60.0;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
          _RW = 6 ;
          _FAR = 3.0;
          _MGC = 60.0;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
           _RW = 9 ;
          _FAR = 3.25;
          _MGC = 57.5;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
           _RW = 9 ;
          _FAR = 3.25;
          _MGC = 57.5;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
           _RW = 9 ;
          _FAR = 3.25;
          _MGC = 57.5;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
          _RW = 9 ;
          _FAR = 3.5;
          _MGC = 55.0;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
           _RW = 12 ;
          _FAR = 3.75;
          _MGC = 52.5;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
          _RW = 12 ;
          _FAR = 4.0;
          _MGC = 52.5;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
          _RW = 12 ;
          _FAR = 4.25;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
          _RW = 12 ;
          _FAR = 4.50;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
          _RW = 12 ;
          _FAR = 4.75;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
           _RW = 12 ;
          _FAR = 5.5;
          _MGC = 50.0;
        });
      }
}


getOfficeBuilding(){
  if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 6 ;
          _FAR = 2.5;
          _MGC = 67.5;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
          _RW = 6 ;
          _FAR = 3.0;
          _MGC = 65;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 6 ;
          _FAR = 3.0;
          _MGC = 65;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
          _RW = 6 ;
          _FAR = 3.5;
          _MGC = 62.5;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
          _RW = 6 ;
          _FAR = 3.5;
          _MGC = 62.5;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
           _RW = 6 ;
          _FAR = 3.75;
          _MGC = 60.0;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
           _RW = 9 ;
          _FAR = 4.5;
          _MGC = 57.5;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
          _RW = 9 ;
          _FAR = 5.5;
          _MGC = 57.5;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
          _RW = 9 ;
          _FAR = 6.0;
          _MGC = 55.0;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
          _RW = 9 ;
          _FAR = 6.5;
          _MGC = 55.0;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
          _RW = 9 ;
          _FAR = 7.0;
          _MGC = 52.5;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
          _RW = 9 ;
          _FAR = 7.5;
          _MGC = 52.5;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
          _RW = 9 ;
          _FAR = 8.0;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
          _RW = 9 ;
          _FAR = 8.5;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
           _RW = 9 ;
          _FAR = 9.5;
          _MGC = 50.0;
        });
      }
}

getReligious(){
  if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 6 ;
          _FAR = 2;
          _MGC = 65;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
          _RW = 6 ;
          _FAR = 2;
          _MGC = 65;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 6 ;
          _FAR = 2.25;
          _MGC = 60;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
          _RW = 6 ;
          _FAR = 2.25;
          _MGC = 60;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
           _RW = 9 ;
          _FAR = 2.5;
          _MGC = 57.5;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
            _RW = 9 ;
          _FAR = 2.5;
          _MGC = 57.5;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
           _RW = 9 ;
          _FAR = 2.75;
          _MGC = 55.0;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
          _RW = 9 ;
          _FAR = 2.75;
          _MGC = 55.0;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
          _RW = 9 ;
          _FAR = 3.0;
          _MGC = 52.5;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
          _RW = 12 ;
          _FAR = 3.25;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
          _RW = 12 ;
          _FAR = 3.5;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
          _RW = 12 ;
          _FAR = 3.75;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
          _RW = 12 ;
          _FAR = 4.0;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
          _RW = 12 ;
          _FAR = 4.25;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
           _RW = 12 ;
          _FAR = 5.5;
          _MGC = 50.0;
        });
      }
}


getHealth(){
  if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 0 ;
          _FAR = 0;
          _MGC = 0;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
           _RW = 0 ;
          _FAR =0;
          _MGC = 0 ;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 0 ;
          _FAR = 0;
          _MGC = 0 ;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
           _RW = 0 ;
          _FAR = 0;
          _MGC = 0;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.25;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
            _RW = 6.0 ;
          _FAR = 3.25;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.25;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 3.50;
          _MGC = 57.5;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 3.50;
          _MGC = 57.5;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 3.75;
          _MGC = 55.0;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 4.0;
          _MGC = 55.0;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 4.25;
          _MGC = 52.5;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 4.50;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 4.75;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
            _RW = 12.0 ;
          _FAR = 5.0;
          _MGC = 50.0 ;
        });
      }
}


getInstitute(){
  if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 0 ;
          _FAR = 0;
          _MGC = 0;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
           _RW = 0 ;
          _FAR =0;
          _MGC = 0 ;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 0 ;
          _FAR = 0;
          _MGC = 0 ;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
           _RW = 0 ;
          _FAR = 0;
          _MGC = 0;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.25;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
            _RW = 6.0 ;
          _FAR = 3.25;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.25;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 3.50;
          _MGC = 57.5;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 3.50;
          _MGC = 57.5;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 3.75;
          _MGC = 55.0;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 4.0;
          _MGC = 55.0;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 4.25;
          _MGC = 52.5;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 4.50;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 4.75;
          _MGC = 50.0;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
            _RW = 12.0 ;
          _FAR = 5.0;
          _MGC = 50.0 ;
        });
      }
}

getkindergarden(){
  if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 0 ;
          _FAR = 0;
          _MGC = 0;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
           _RW = 0 ;
          _FAR =0;
          _MGC = 0 ;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 0 ;
          _FAR = 0;
          _MGC = 0 ;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
           _RW = 0 ;
          _FAR = 0;
          _MGC = 0;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 2.00;
          _MGC = 50.0 ;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 2.00;
          _MGC = 50.0 ;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
          _RW = 6.0 ;
          _FAR = 2.00;
          _MGC = 50.0 ;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 2.25;
          _MGC = 50.0 ;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 2.25;
          _MGC = 50.0 ;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 2.50;
          _MGC = 50.0 ;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 2.50;
          _MGC = 50.0 ;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
           _RW = 9.0 ;
          _FAR = 2.75;
          _MGC = 50.0 ;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
           _RW = 9.0 ;
          _FAR = 2.75;
          _MGC = 50.0 ;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 3.00;
          _MGC = 50.0 ;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
            _RW = 12.0 ;
          _FAR = 3.50;
          _MGC = 50.0 ;
        });
      }
}


getSchool(){
  if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 0 ;
          _FAR = 0;
          _MGC = 0;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
           _RW = 0 ;
          _FAR =0;
          _MGC = 0 ;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 0 ;
          _FAR = 0;
          _MGC = 0 ;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
           _RW = 0 ;
          _FAR = 0;
          _MGC = 0;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 2.50;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 2.50;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 2.50;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
          _RW = 6.0 ;
          _FAR = 2.75;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 2.75;
          _MGC = 60.0 ;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
           _RW = 9.0 ;
          _FAR = 3.0;
          _MGC = 57.0 ;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
          _RW = 9.0 ;
          _FAR = 3.0;
          _MGC = 55.0 ;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
           _RW = 9.0 ;
          _FAR = 3.25;
          _MGC = 53.0 ;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
           _RW = 9.0 ;
          _FAR = 3.25;
          _MGC = 50.0 ;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
            _RW = 9.0 ;
          _FAR = 3.50;
          _MGC = 50.0 ;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
             _RW = 12.0 ;
          _FAR = 4.0;
          _MGC = 50.0 ;
        });
      }
}

getResidentialHotel(){
if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 6.0 ;
          _FAR = 2.50;
          _MGC = 67.5 ;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
           _RW = 6.0 ;
          _FAR =2.75;
          _MGC = 65 ;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.0;
          _MGC = 62.5 ;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.25;
          _MGC = 62.5 ;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.50;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.75;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 4.5;
          _MGC = 57.5 ;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
           _RW = 9.0 ;
          _FAR = 5.5;
          _MGC = 57.5 ;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
           _RW = 9.0 ;
          _FAR = 6.0;
          _MGC = 55 ;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
           _RW = 9.0;
          _FAR = 6.5;
          _MGC = 55 ;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
           _RW = 9.0;
          _FAR = 7.0;
          _MGC = 52.5 ;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
           _RW = 9.0;
          _FAR = 7.5;
          _MGC = 52.5 ;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
           _RW = 9.0;
          _FAR = 8.0;
          _MGC = 50 ;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
           _RW = 9.0;
          _FAR = 8.5;
          _MGC = 50 ;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
           _RW = 12;
          _FAR = 9.5;
          _MGC = 50 ;
        });
      }
}

getResidentialBuilding(){
    if((ptype == 1 && _area <=134) || (ptype == 2 && _area <=2) ){
        setState(() {
          _RW = 6.0 ;
          _FAR = 3.15;
          _MGC = 67.5 ;
        });
      }else if ((ptype == 1 && _area >134 && _area <= 201 ) || (ptype == 2 && _area > 2 && _area <=3)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.35;
          _MGC = 65 ;
        });
      }else if ((ptype == 1 && _area >201 && _area <= 265 ) || (ptype == 2 && _area > 3 && _area <=4)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.50;
          _MGC = 62.5 ;
        });
      }else if ((ptype == 1 && _area >265 && _area <= 335 ) || (ptype == 2 && _area > 4 && _area <=5)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.50;
          _MGC = 62.5 ;
        });
      }else if ((ptype == 1 && _area >335 && _area <= 402 ) || (ptype == 2 && _area > 5 && _area <=6)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.75;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >402 && _area <= 469 ) || (ptype == 2 && _area > 6 && _area <=7)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 3.75;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >469 && _area <= 536 ) || (ptype == 2 && _area > 7 && _area <=8)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 4.0;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >536 && _area <= 603 ) || (ptype == 2 && _area > 8 && _area <=9)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 4.0;
          _MGC = 60.0 ;
        });
      }else if ((ptype == 1 && _area >603 && _area <= 670 ) || (ptype == 2 && _area > 9 && _area <=10)){
        setState(() {
           _RW = 6.0 ;
          _FAR = 4.25;
          _MGC = 57.5 ;
        });
      }
      else if ((ptype == 1 && _area >670 && _area <= 804 ) || (ptype == 2 && _area > 10 && _area <=12)){
        setState(() {
           _RW = 9.0;
          _FAR = 4.50;
          _MGC = 57.5 ;
        });
      }
      else if ((ptype == 1 && _area >804 && _area <= 938 ) || (ptype == 2 && _area > 12 && _area <=14)){
        setState(() {
           _RW = 9.0;
          _FAR = 4.75;
          _MGC = 55.0 ;
        });
      }
      else if ((ptype == 1 && _area >938 && _area <= 1072 ) || (ptype == 2 && _area > 14 && _area <=16)){
        setState(() {
           _RW = 9.0;
          _FAR = 5.0;
          _MGC = 52.5 ;
        });
      }
      else if ((ptype == 1 && _area >1072 && _area <= 1206 ) || (ptype == 2 && _area > 16 && _area <=18)){
        setState(() {
           _RW = 9.0;
          _FAR = 5.25;
          _MGC = 52.5 ;
        });
      }
      else if ((ptype == 1 && _area >1206 && _area <= 1340 ) || (ptype == 2 && _area > 18 && _area <=20)){
        setState(() {
           _RW = 9.0;
          _FAR = 5.25;
          _MGC = 50.0 ;
        });
      }
      else if ((ptype == 1 && _area >1340 ) || (ptype == 2 && _area > 20)){
        setState(() {
           _RW = 12;
          _FAR = 5.5;
          _MGC = 50 ;
        });
      }
    }
  



}