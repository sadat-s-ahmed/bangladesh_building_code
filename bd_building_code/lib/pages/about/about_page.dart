import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
      final text = '''
    Hello mister what me i find 
    '''.replaceAll("\n", "\n\n").replaceAll("  ", "");


    String search;
    TextStyle posRes = TextStyle(color: Colors.black, backgroundColor: Colors.red),
        negRes = TextStyle(color: Colors.black, backgroundColor: Colors.white);

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
      appBar: AppBar(
              backgroundColor: Colors.white,
              title: TextField(
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(hintText: "Search"),
                onChanged: (t) {
                  setState(() => search = t);
                },
              ),
            ),
      body:Scrollbar(
              child: SingleChildScrollView(
                child: ListView(
                  children: <Widget>[
                    RichText(
                      textScaleFactor: 1,
                      text: searchMatch(
                        text,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}