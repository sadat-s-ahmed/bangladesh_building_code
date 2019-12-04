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
  final double _initFabHeight = 150.0;
  double _fabHeight;
  double _panelHeightOpen = 575.0;
  double _panelHeightClosed = 150.0;

  int ptype = 1 ;
  List deshi = [
    {
      "display": "Acre",
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
      "display": "Katha",
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
      "display": "Til",
      "value": 26,
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
      height: 150,
      padding: EdgeInsets.only(
        left: 10,
        right: 10 

      ),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Container(
                height: 120,
                    padding: EdgeInsets.all(16),
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
                          ptype = int.parse(value);
                        });
                        _convertValue(ptype);
                      },
                      onChanged: (value) {
                        setState(() {
                          ptype = int.parse(value);
                        });
                        _convertValue(ptype);
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
          //   iconSize: 10.0,
          //   icon: Icon(Icons.filter_list),
          //   onPressed: (){},
          // )    
        ],
      )
    );
  }
_convertValue(int p){
  if(calculatorString.length > 0 ){
    calculatorString += "*12";
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