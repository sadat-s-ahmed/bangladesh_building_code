import 'package:flutter/cupertino.dart';

class NumberDisplay extends StatelessWidget {
   NumberDisplay({this.value: '', this.type});
  final bool type;
  final String value;    
  @override
  Widget build(BuildContext context) {
    return Padding( 
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment : MainAxisAlignment.end ,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold ),
            ),
          ],
        )
    );
  }
}