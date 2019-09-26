import 'package:bd_building_code/component/boxfeild.dart';
import 'package:bd_building_code/component/responsive_screen.dart';
import 'package:bd_building_code/component/tabs_chips.dart';
import 'package:bd_building_code/component/upper_curve_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color backgroundColor = Color.fromRGBO(0, 55, 84,1);
Color bg_grad = Color.fromRGBO(0, 55, 84,1);
Color bg_grad2 = Color.fromRGBO(8, 88, 149,1);


class FarCard{
  String id;
  String image;
  String type;
  String buildingType;
  String roadwidth;
  // String far;
  // String mgc;
  // String existingLandArea;
  // String maximumBuildArea;
  // String maximunGroundCoverage;
  // String noFloors;
  // String finalFloors;

  FarCard({this.id,
     this.image,
     this.type,
     this.buildingType,
     this.roadwidth
     });


}


class Far_page extends StatefulWidget {
  Far_page({Key key}) : super(key: key);

  _Far_pageState createState() => _Far_pageState();
}

class _Far_pageState extends State<Far_page> {
  Screen size;
  Map<int, Widget> _types() => {
    0: Text('Square feet'),
    1: Text('Katha'),
  };
  int _selectedType= 0;
  int _selectedColorIndex = 0;
  List<FarCard> farlists =  List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    farlists
    ..add(FarCard(buildingType: 'Omkar Lotus',image:'assets/sketch.png',roadwidth: 'Ahmedabad' , type: 'Building' ))
    ..add(FarCard(buildingType: 'Omkar Lotus',image:'assets/home.png',roadwidth: 'Ahmedabad' , type: 'Building2' ))
    ..add(FarCard(buildingType: 'Omkar Lotus',image:'assets/sketch.png',roadwidth: 'Ahmedabad' , type: 'Building3' ));
  }




  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: CupertinoColors.black,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: CupertinoColors.white),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[upperPart()],
            ),
          ),
        ),
      ),
    );
    
  }

  upperPart(){
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: size.getWidthPx(240),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [bg_grad, bg_grad2],
              ),
            ),
          ),
        ),

        Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: size.getWidthPx(36)),
              child: Column(
                children: <Widget>[
                    titleWidget(),
                    SizedBox(height: size.getWidthPx(10)),
                    upperBoxCard()
                ],
              ),
            ),
            // leftAlignText(
            //     text: "Previous Far Calculations",
            //     leftPadding: size.getWidthPx(16),
            //     textColor: bg_grad2,
            //     fontSize: 16.0
            // ),
            // HorizontalList(
            //   children: <Widget>[
            //     for (int i = 0; i < farlists.length; i++)
            //       propertyCard(farlists[i])
            //   ],
            // ),
          ],
        )
      ],
    );
  }
  Card propertyCard(FarCard property) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        borderOnForeground: true,
        child: Container(
            height: size.getWidthPx(150),
            width: size.getWidthPx(170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)),
                    child: Image.asset('assets/${property.image}',
                        fit: BoxFit.fill)),
                SizedBox(height: size.getWidthPx(8)),
                leftAlignText(
                    text: property.buildingType,
                    leftPadding: size.getWidthPx(8),
                    textColor: bg_grad,
                    fontSize: 14.0),
                leftAlignText(
                    text: property.type,
                    leftPadding: size.getWidthPx(8),
                    textColor: Colors.black54,
                    fontSize: 12.0),
                SizedBox(height: size.getWidthPx(4)),
                leftAlignText(
                    text: property.roadwidth,
                    leftPadding: size.getWidthPx(8),
                    textColor: bg_grad2,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800),
              ],
            )));
  }
  Text titleWidget() {
    return Text("FAR Calculator",
    textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Exo2',
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.white)
            );
  }

  Card upperBoxCard() {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(20), vertical: size.getWidthPx(16)),
        borderOnForeground: true,
        child: Container(
          height: size.getWidthPx(150),
          child: Column(
            children: <Widget>[
              _typesFeild(),
              // _chooseBuildingTypes(),
              // _buildColorPicker(context),
              //     Text('Plot Size' , 
              //       textAlign:TextAlign.start,
              //     ),
              _searchWidget(),
              _lenghtandwidth(),
              _generateButton()
              
            ],
          ),
        ));
  } 
    Container _generateButton() {
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
          "Generate",
          style: TextStyle(
            fontFamily: 'Exo2',
            color: Colors.white, 
            fontSize: 20.0),
        ),
        color: bg_grad2,
        onPressed: () {
          
          
        },
      ),
    );
  }
  Widget _chooseBuildingTypes(){
    return null;
  }
  Widget _lenghtandwidth(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BoxField(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Lenght",
        lableText: "Lenght",
        obscureText: false,
        onSaved: (String val) {},
        icon: Icons.linear_scale,
        iconColor: bg_grad),
        BoxField(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Width",
        lableText: "Width",
        obscureText: false,
        onSaved: (String val) {},
        icon: Icons.format_line_spacing,
        iconColor: bg_grad),
      ],
    ) ; 
  }


  Widget _typesFeild(){
    return Expanded(
      flex: 1,
      child: CupertinoSegmentedControl(
          children: _types(),
          groupValue: _selectedType,
          onValueChanged: (value){
            setState(() {
              _selectedType = value  ;
            });
          },
        ),
    );
  }

  BoxField _searchWidget() {
    return BoxField(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Enter Your Plot Area",
        lableText: "Enter Your Plot Area",
        obscureText: false,
        onSaved: (String val) {},
        icon: Icons.linear_scale,
        iconColor: bg_grad);
  }


    Padding leftAlignText({text, leftPadding, textColor, fontSize, fontWeight}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text??"",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor)),
      ),
    );
  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:CupertinoNavigationBar(
//         middle: Text('FAR Calculator'),
//       ),
//       body:
//       Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Expanded(
//               child: ListView(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 16 ),
//                 children: <Widget>[
//                   SizedBox(height: 20,),
//                   Text('Unit of Plot' , 
//                     textAlign:TextAlign.start,
//                   ),
//                   CupertinoSegmentedControl(
//                     children: _types(),
//                     groupValue: _selectedType,
//                     onValueChanged: (value){
//                       setState(() {
//                        _selectedType = value  ;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 20,),
//                   Text('Type of Building' , 
//                     textAlign:TextAlign.start,
//                   ),
//                   _buildColorPicker(context),
//                   Text('Plot Size' , 
//                     textAlign:TextAlign.start,
//                   ),
//                   _buildPlotArea(context, _selectedType ,
//                   _selectedColorIndex ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       )
      
//     );
//   }

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
                backgroundColor: CupertinoColors.white,
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