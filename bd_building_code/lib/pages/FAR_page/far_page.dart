import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Far_page extends StatefulWidget {
  Far_page({Key key}) : super(key: key);

  _Far_pageState createState() => _Far_pageState();
}

class _Far_pageState extends State<Far_page> {
  Map<int, Widget> _types() => {
    0: Text('Square feet'),
    1: Text('Katha'),
  };
  int _selectedType= 0;
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CupertinoNavigationBar(
        middle: Text('FAR Calculator'),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 16 ),
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text('Unit of Plot' , 
                    textAlign:TextAlign.start,
                  ),
                  CupertinoSegmentedControl(
                    children: _types(),
                    groupValue: _selectedType,
                    onValueChanged: (value){
                      setState(() {
                       _selectedType = value  ;
                      });
                    },
                  ),
                  SizedBox(height: 20,),
                  Text('Type of Building' , 
                    textAlign:TextAlign.start,
                  ),
                  _buildColorPicker(context),
                  Text('Plot Size' , 
                    textAlign:TextAlign.start,
                  ),
                  _buildPlotArea(context, _selectedType ,
                  _selectedColorIndex ),
                ],
              ),
            )
          ],
        ),
      )
      
    );
  }

    Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () { },
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
  Widget _buildColorPicker(BuildContext context) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: _selectedColorIndex);

    return GestureDetector(
      onTap: () async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoPicker(
                scrollController: scrollController,
                itemExtent: 32.0,
                backgroundColor: CupertinoColors.activeBlue,
                onSelectedItemChanged: (int index) {
                  setState(() => _selectedColorIndex = index);
                },
                children: List<Widget>.generate(coolColorNames.length, (int index) {
                  return Center(
                    child: Text(coolColorNames[index]),
                  );
                }),
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          const Text('Favorite Color'),
          Text(
            coolColorNames[_selectedColorIndex],
            style: const TextStyle(
                color: CupertinoColors.inactiveGray
            ),
          ),
        ],
      ),
    );
  }
   Widget _buildMenu(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
          bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
        ),
      ),
      height: 44.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      ),
    );
  }
 List<String> coolColorNames = <String>[
  'Sarcoline', 'Coquelicot', 'Smaragdine', 'Mikado', 'Glaucous', 'Wenge',
  'Fulvous', 'Xanadu', 'Falu', 'Eburnean', 'Amaranth', 'Australien',
  'Banan', 'Falu', 'Gingerline', 'Incarnadine', 'Labrador', 'Nattier',
  'Pervenche', 'Sinoper', 'Verditer', 'Watchet', 'Zaffre',
];

 Widget _buildPlotArea(BuildContext context ,int flag, int type ){
   TextEditingController _plotsizeController ; 
   return TextFormField(
     controller: _plotsizeController,
    keyboardType: TextInputType.number,
    decoration: const InputDecoration(
      icon: const Icon(Icons.calendar_today),
      hintText: 'Enter your date of birth',
      labelText: 'Dob',
    ),
    validator:(val) => isValidate(val, flag, type) ? null : "This Value is not applicable!" ,
     
   );
 }

 bool isValidate(val, int flag, int type){
   return true;
 }

}