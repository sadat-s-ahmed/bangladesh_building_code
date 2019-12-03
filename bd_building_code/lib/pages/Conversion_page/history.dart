import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calculator.dart';

class History extends StatelessWidget {
  
  History({@required this.operations , this.getHistory});
  final Function getHistory ;
  final List<String> operations;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Center(
          child:
          //Text('Hello')
          _operationsList(operations),
        ),
    );
  }

  Widget _operationsList(List<String> operations) {
    return ListView.separated(
      separatorBuilder: (context , index) => Divider(
        color: Colors.black,
      ),
      itemCount: operations.length,
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          title: Text(operations[i]),
          onTap: () {
            print(operations[i]);
            getHistory(Calculator.parseString(operations[i]));
          },
          leading: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red[800], width: 2.0),
              borderRadius: BorderRadius.circular(50)
            ),
            child: Text(
              Calculator.parseString(operations[i]),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(5),
          ),
          
        );
      },
    );
  }
}