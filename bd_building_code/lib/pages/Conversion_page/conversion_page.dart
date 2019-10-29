import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calculator.dart';
import 'number-display.dart';
import 'calculator-buttons.dart';
import 'history.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:decimal/decimal.dart';

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
  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen = 575.0;
  double _panelHeightClosed = 100.0;

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
                panel:History(operations: calculations),
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
  Widget _buttons(){
    return Container(
      padding: EdgeInsets.only(
        top: 50 , bottom: 5 , left: 20,right: 20  
       ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            GestureDetector(
            onTap: (){
              setState(() {
              conversionType= !this.conversionType; 
              });
              if(conversionType){
              _onPressed(buttonText: '*');
              _onPressed(buttonText: '1');
              _onPressed(buttonText: '2');
              _onPressed(buttonText: '=');
              }else{
                _onPressed(buttonText: '/');
              _onPressed(buttonText: '1');
              _onPressed(buttonText: '2');
              _onPressed(buttonText: '=');
              }
              
            },
            child: Text(this.conversionType ? 'inch' : 'ft'),
          ) ,
          // Positioned(
          //       top: 30.0,
          //       left: 20,
          //       child: GestureDetector(
          //         onTap: (){},
          //         child: Icon(CupertinoIcons.down_arrow)
          //   ),
          // )
           
        ],
      )
    );
  }

   Widget _body(){
     return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //SizedBox(height: 100,),
                
                Spacer(),
                // conversionButton(),

                NumberDisplay(value: calculatorString , type: conversionType),
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