import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calculator.dart';
import 'number-display.dart';
import 'calculator-buttons.dart';
import 'history.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:decimal/decimal.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';


Color bg_color = Colors.white ;

class ConversionPage extends StatefulWidget {
  ConversionPage({Key key}) : super(key: key);

  _ConversionPageState createState() => _ConversionPageState();
}


class _ConversionPageState extends State<ConversionPage> {
  bool isNewEquation = true;
  List<double> values = [];
  List<String> operations = [];
  List<String> calculations = [];
  String calculatorString = '';
  bool conversionType = false;
  //flase => ft , true =>  inches
  final double _initFabHeight = 140.0;
  double _fabHeight;
  double _panelHeightOpen = 575.0;
  double _panelHeightClosed = 140.0;

  int ptype = 1 ;
  int btype = 1  ;
  List deshi = [
    {
      "display": "Katha",
      "value": 1,
    },
    {
      "display": "Ayer",
      "value": 2,
    },
    {
      "display": "Bigha",
      "value": 3,
    },
    {
      "display": "Chotak",
      "value": 4,
    },
    {
      "display": "Decimal",
      "value": 5,
    },
    {
      "display": "Dhul",
      "value": 6,
    },
    {
      "display": "Dondho",
      "value": 7,
    },
    {
      "display": "Gonda",
      "value": 8,
    },
    {
      "display": "Hectare",
      "value": 9,
    },
    {
      "display": "Kak",
      "value": 10,
    },
    {
      "display": "Kani",
      "value": 11,
    },
    {
      "display": "Acre",
      "value": 12,
    },
    {
      "display": "Kontha",
      "value": 13,
    },
    {
      "display": "Kora",
      "value": 14,
    },
    {
      "display": "Kranti",
      "value": 15,
    },
    {
      "display": "Ojutangsho",
      "value": 16,
    },
    {
      "display": "Renu",
      "value": 17,
    },
    {
      "display": "Sotak",
      "value": 18,
    },
    {
      "display": "Shotangsho",
      "value": 19,
    },
    {
      "display": "Square Chain",
      "value": 20,
    },
    {
      "display": "Square Feet ",
      "value": 21,
    },
    {
      "display": "Square Hat",
      "value": 22,
    },
    {
      "display": "Square Inchi",
      "value": 23,
    },
    {
      "display": "Square Link",
      "value": 24,
    },
    {
      "display": "Square Meter ",
      "value": 25,
    },
    {
      "display": "Square Yard",
      "value": 26,
    },
    {
      "display": "Til",
      "value": 27,
    },
  ];



  void initState(){
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // navigationBar: CupertinoNavigationBar(
      //   leading: Text('Conversion Calculator'),
      //   trailing: GestureDetector(
      //       onTap: (){
      //         _navigateAndDisplayHistory(context);
      //       },
      //       child: Icon(CupertinoIcons.time)
      //   ),
      // ),
      body:LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
        child:SlidingUpPanel(
                boxShadow: null ,
                slideDirection: SlideDirection.DOWN,
                maxHeight: _panelHeightOpen,
                minHeight: _panelHeightClosed,
                collapsed: _buttons(),
                body: _body(),
                panel:History(operations: calculations , getHistory: _setHistory ),
                onPanelSlide: (double pos) => setState((){
                  _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
                }),
              ),
        ),
      ) ;
      
      }
      )
    );
  }

_setHistory(var x){
  print(x);
  setState(() {
    calculatorString = x ;
  });
}

  Widget _buttons(){
    return Container(
      height: 100,
      padding: EdgeInsets.only(
        top: 15,
        left: 10,
        right: 10 

      ),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Container(
                height: 100,
                    padding: EdgeInsets.all(5),
                    child: DropDownFormField(
                      validator: (val){
                       if( val == null ){
                        return 'Please Select an Option';
                      }
                      return null;
                      },
                      required: true,
                      titleText: '',
                      hintText: 'Please choose one',
                      value: ptype,
                      onSaved: (value) {
                        setState(() {
                          btype = ptype ;
                          ptype = value;
                        });
                        _convertValue(ptype , btype );
                      },
                      onChanged: (value) {
                          btype = ptype ;
                          ptype = value;
                      
                        _convertValue(ptype , btype);
                      },
                      dataSource:deshi,
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start, 
            
          //   children: <Widget>[

              
          //     RaisedButton(
          //       onPressed: (){
          //         if(calculatorString.length > 0 ){
          //           if(conversionType){
          //         calculatorString += "*12";
          //         _onPressed(buttonText: '=');
          //         }else{
          //          calculatorString += "/12";
          //         _onPressed(buttonText: '=');
          //         }
          //         setState(() {
          //         conversionType= !this.conversionType; 
          //         });
          //         }
          //       },
          //       child: Text(this.conversionType ? 'inch' : 'ft'),
          //     ) 
          //   ],
          // ),
          //   IconButton(
          //   iconSize: 5.0,
          //   icon: Icon(Icons.filter_list),
          //   onPressed: (){},
          // )    
        ],
      )
    );
  }
_convertValue(int pt , int bt){
  if(calculatorString.length > 0 ){

    print(pt );
    print(bt);
    if(bt == 1 ) {
        _forwardCalc(pt);
    }else  {
       _backwardCalc(bt );
       _forwardCalc(pt);
    }
    // calculatorString += "*$p";
    // _onPressed(buttonText: '=');
  }else {
    Fluttertoast.showToast(
                msg: "Please Input Values First ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 10.0);   
  }
}

_forwardCalc(int x){
  if(x == 1){
      calculatorString += "*$x";
     _onPressed(buttonText: '=');
  }else if(x ==2 ){
      var r = 0.668;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if (x == 3 ){
     var r = 0.05;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==4){
     var r = 16;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==5){
     var r = 1.652;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==6){
     var r =419.99;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==7){
     var r = 60;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==8){
     var r = 0.833;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==9){
     var r = 0.006638;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==10){
     var r = 13.33;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==11){
     var r = 0.0416;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==12){
     var r = 0.0165;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==13){
     var r = 10;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==14){
     var r = 3.33;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==15){
     var r = 9.917;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==16){
     var r = 165.289;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==17){
     var r = 12600;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==18){
     var r = 1.652;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==19){
     var r = 1.652;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==20){
     var r =  0.1654;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==21){
     var r = 720;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==22){
     var r =  320;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==23){
     var r = 103680.06;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==24){
     var r =  1652.892;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==25){
     var r = 66.89;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==26){
     var r = 80;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }else if(x==27){
     var r = 198.3471;
     calculatorString += "*$r";
     _onPressed(buttonText: '=');
  }
  
  
}

_backwardCalc(int x){
  if(x == 1){
      calculatorString += "/$x";
     _onPressed(buttonText: '=');
  }else if(x ==2 ){
      var r = 0.668;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if (x == 3 ){
     var r = 0.05;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==4){
     var r = 16;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==5){
     var r = 1.652;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==6){
     var r =419.99;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==7){
     var r = 60;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==8){
     var r = 0.833;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==9){
     var r = 0.006638;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==10){
     var r = 13.33;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==11){
     var r = 0.0416;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==12){
     var r = 0.0165;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==13){
     var r = 10;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==14){
     var r = 3.33;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==15){
     var r = 9.917;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==16){
     var r = 165.289;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==17){
     var r = 12600;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==18){
     var r = 1.652;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==19){
     var r = 1.652;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==20){
     var r =  0.1654;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==21){
     var r = 720;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==22){
     var r =  320;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==23){
     var r = 103680.06;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==24){
     var r =  1652.892;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==25){
     var r = 66.89;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==26){
     var r = 80;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }else if(x==27){
     var r = 198.3471;
     calculatorString += "/$r";
     _onPressed(buttonText: '=');
  }
}


   Widget _body(){
     return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //SizedBox(height: 100,),
                
                Spacer(),
                // conversionButton(),
                 Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    
                    child: NumberDisplay(value: calculatorString , type: conversionType),
                  ),
                ),
                
                CalculatorButtons(onTap: _onPressed),
                
              ],
            ),
     );
    }

    Widget conversionButton(){
      return null ;
    }

    _navigateAndDisplayHistory(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => History(operations: calculations))
    );

    if (result != null) {
      setState(() {
        isNewEquation = false;
        calculatorString = Calculator.parseString(result);
      });
    }
  }
  
   void _onPressed({String buttonText}) {
    // Standard mathematical operations
    if (Calculations.OPERATIONS.contains(buttonText)) {
      return setState(() {
        operations.add(buttonText);
        calculatorString += " $buttonText ";
      });
    }

    // On CLEAR press
    if (buttonText == Calculations.CLEAR) {
      return setState(() {
        operations.add(Calculations.CLEAR);
        calculatorString = "";
        
      });
    }

    // On Equals press
    if (buttonText == Calculations.EQUAL) {
      String newCalculatorString = Calculator.parseString(calculatorString);

      return setState(() {
        if (newCalculatorString != calculatorString) {
          // only add evaluated strings to calculations array
          calculations.add(calculatorString);
        }

        operations.add(Calculations.EQUAL);
        calculatorString = newCalculatorString;
        isNewEquation = false;
      });
    }

    if (buttonText == Calculations.PERIOD) {
      return setState(() {
        calculatorString = Calculator.addPeriod(calculatorString);
      });
    }

    setState(() {
      if (!isNewEquation
          && operations.length > 0
          && operations.last == Calculations.EQUAL
      ) {
        calculatorString = buttonText;
        isNewEquation = true;
      } else {
        calculatorString += buttonText;
      }
    });

    //logics needed
    // two operand connot exist togather
    // inches to feet converter 
    //doesnot handle decimals very well 
    

  }


}