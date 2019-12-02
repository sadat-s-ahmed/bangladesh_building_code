import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;


Color backgroundColor = Colors.grey.shade200;
Color appbarColor = Colors.black;
Color bg_grad = Color.fromRGBO(58, 58,58,1);
Color bg_grad2 = Color.fromRGBO(58, 58, 58,.7);
Color grads = Color.fromRGBO(189 , 195 , 199, 1);
Color grads2 = Color.fromRGBO(44  , 62  , 80, 1);
Color gradinner1 = Color.fromRGBO(142 , 158 , 171, 1);
Color gradinner2 = Color.fromRGBO(238, 242 , 243, 1);



class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
List list   ;
String text ; 
@override
void initState() { 
  super.initState();
  getBearings();
  
}
getBearings() async{
  loadAsset(context).then((s){
    print(s.split('Chapter').length);
    list = s.split('Chapter');
    text = list[0] ; 
  });
}

Future<String> loadAsset(BuildContext context) async {
  return await DefaultAssetBundle.of(context).loadString('assets/BNBC.txt');
}

TextStyle posRes = TextStyle(color: Colors.white, backgroundColor: Colors.red),
    negRes = TextStyle(color: Colors.black, backgroundColor: Colors.white);

String search;


// final text = '''
// Call me Ishmael. Some years ago—never mind how long precisely—having
// little or no money in my purse, and nothing particular to interest me
// on shore, I thought I would sail about a little and see the watery part
// of the world. It is a way I have of driving off the spleen and
// regulating the circulation. Whenever I find myself growing grim about
// the mouth; whenever it is a damp, drizzly November in my soul; whenever
// I find myself involuntarily pausing before coffin warehouses, and
// bringing up the rear of every funeral I meet; and especially whenever
// my hypos get such an upper hand of me, that it requires a strong moral
// principle to prevent me from deliberately stepping into the street, and
// methodically knocking people’s hats off—then, I account it high time to
// get to sea as soon as I can. This is my substitute for pistol and ball.
// With a philosophical flourish Cato throws himself upon his sword; I
// quietly take to the ship. There is nothing surprising in this. If they
// but knew it, almost all men in their degree, some time or other,
// cherish very nearly the same feelings towards the ocean with me.
// '''.replaceAll("\n", " ").replaceAll("  ", "");

TextSpan searchMatch(String match) {
  if (search == null || search == "")
    return TextSpan(text: match, style: negRes);
  var refinedMatch = match.toLowerCase();
  var refinedSearch = search.toLowerCase();
  if (refinedMatch.contains(refinedSearch)) {
    if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
      return TextSpan(
        style: posRes,
        text: match.substring(0, refinedSearch.length),
        children: [
          searchMatch(
            match.substring(
              refinedSearch.length,
            ),
          ),
        ],
      );
    } else if (refinedMatch.length == refinedSearch.length) {
      return TextSpan(text: match, style: posRes);
    } else {
      return TextSpan(
        style: negRes,
        text: match.substring(
          0,
          refinedMatch.indexOf(refinedSearch),
        ),
        children: [
          searchMatch(
            match.substring(
              refinedMatch.indexOf(refinedSearch),
            ),
          ),
        ],
      );
    }
  } else if (!refinedMatch.contains(refinedSearch)) {
    return TextSpan(text: match, style: negRes);
  }
  return TextSpan(
    text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
    style: negRes,
    children: [
      searchMatch(match.substring(refinedMatch.indexOf(refinedSearch)))
    ],
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
            appBar:PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                  child: AppBar(
                  backgroundColor:appbarColor ,
                  elevation: 0.0,
                  centerTitle: true,
                  title: TextField(
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(hintText: "Search"),
                    onChanged: (t) {
                      setState(() => search = t);
                    },
                  ),
                ),
            ), 
            drawer: new Drawer(
              child: FutureBuilder(
                future: loadAsset(context),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    
                    return new ListView.builder(
                      itemCount: snapshot.data.split('Chapter').length,
                      itemBuilder: (context , index ){
                        return ListTile(
                            title: new Text("Chapter $index"),
                            onTap: () {
                              
                              setState(() {
                                 text= list[index];
                              });
                            });
                      },
                    );
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
      ),
            body: Scrollbar(
              child: SingleChildScrollView(
                child: RichText(
                      textScaleFactor: 1,
                      text: searchMatch(
                       text,
                      ),
                    )
                )
                
                
                ,
              ),
          );
  }

  
}