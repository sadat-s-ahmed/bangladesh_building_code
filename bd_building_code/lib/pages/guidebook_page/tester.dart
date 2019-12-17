import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



Color backgroundColor = Colors.grey.shade200;
Color appbarColor = Colors.black;
Color bg_grad = Color.fromRGBO(58, 58, 58, 1);
Color bg_grad2 = Color.fromRGBO(58, 58, 58, .7);
Color grads = Color.fromRGBO(189, 195, 199, 1);
Color grads2 = Color.fromRGBO(44, 62, 80, 1);
Color gradinner1 = Color.fromRGBO(142, 158, 171, 1);
Color gradinner2 = Color.fromRGBO(238, 242, 243, 1);

class TesterPage extends StatefulWidget {
  final String url ;
  final String title ;
  TesterPage({Key key, this.url , this.title}) : super(key: key);

  @override
  _TesterPageState createState() => _TesterPageState();
}

class _TesterPageState extends State<TesterPage> with SingleTickerProviderStateMixin {
  ScrollController _scrollController ;
  List<int> selectedPages =[] ;
  int currentPage ;
  
  String v = 'BookmarkB' ; 
  double height ;
  List list;
  String text;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController() ; 
    // __getChapters(); 
  }

  // getBearings() async {
  //   loadAsset(context).then((s) {
  //     print(s.split("## BNBC 2015 FINAL DRAFT").length);
      
  //     list = s.split('## BNBC 2015 FINAL DRAFT');
  //     text = s[0];
  //   });
  // }

  _jumptoPage(int i ){
      _scrollController.animateTo((i * height)- 100 , duration: new Duration(seconds: 4), curve: Curves.easeInOut);
  }

  Future<String> loadAsset(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/BNBC.txt');
  }

  TextStyle posRes =
          TextStyle(color: Colors.white, backgroundColor: Colors.red),
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

  __getChapters(){
  List<Widget> chaps  = new List<Widget>() ;
  var a  = [0,32 , 42 , 64, 96,155,170,234,242 , 252 , 272 , 311 ];

  for(int i = 1 ; i < a.length ; i++ ){
      chaps.add(
          ListTile(
            title: new Text("Chapter $i" , textAlign: TextAlign.end,),
            onTap: () {
              setState(() {
                  _jumptoPage(a[i]);
              });
            })
        );
    }
  return ListView(
    shrinkWrap: true ,
    children: chaps ,
  );
}
_updateBookmarks() async{
  final bookmarks = new FlutterSecureStorage();
  String s = await bookmarks.read(key: v);
  if(s != null ){
    print(s);
    s.split(',').forEach((a){
      
        
        if(a != ""){
          int i =int.parse(a);

          if(!selectedPages.contains(i)){
            setState(() {
              selectedPages.add(i);
            });
            
          };
        }
        
        
    });
    // print(selectedPages);
  }
}



_getBookmarks(){
  _updateBookmarks() ;
    List<Widget> book  = new List<Widget>() ;
  for(int i = 0 ; i < selectedPages.length ; i++ ){
      int s =  selectedPages[i] -1  ; 
      book.add(
          ListTile(
            title: new Text("page $s"  , textAlign: TextAlign.end,),
            onTap: () {
              setState(() {
                  _jumptoPage(s);
              });
            })
        );
    }
    return ListView(
    shrinkWrap: true ,
    children: book ,
  );
   

  }

_writeBookmarks() async{
  selectedPages.sort();
  String s  = "";
  selectedPages.forEach((a){
    s += "$a," ;
  });
  final bookmarks = new FlutterSecureStorage();
  bookmarks.delete(key: v);
  await bookmarks.write(key: v, value: s );
}


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height ; 

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: appbarColor,
          elevation: 0.0,
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
            child: TextField(
              showCursor: true,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(hintText: "Search for a word..."),
              onChanged: (t) {
              
                setState(() => search = t);
              },
            ),
          ),
        ),
      ),
      drawer:Drawer(
        
        child:SafeArea(
            maintainBottomViewPadding: true,
                    child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    
                    child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            
                            color:appbarColor,
                            child: new UserAccountsDrawerHeader(
                              accountName: new Text(widget.title == null ? "" : widget.title , style: TextStyle(fontSize: 25 ),),
                              accountEmail: new Text(" "),
                              decoration: BoxDecoration(
                                color:  appbarColor,
                              ),
                              // decoration: new BoxDecoration(
                              //   image: new DecorationImage(
                              //     image: new ExactAssetImage('assets/images/lake.jpeg'),
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              // currentAccountPicture: CircleAvatar(
                              //     backgroundImage: NetworkImage(
                              //         "https://randomuser.me/api/portraits/men/46.jpg")),
                            ),
                          ),
                          Text("Chapters", style: TextStyle(fontSize: 22 ,fontWeight: FontWeight.bold),),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(left: 25 , right: 10),
                            child: __getChapters(),
                          ),
                          Text("Bookmarked Pages", style: TextStyle(fontSize: 22 ,fontWeight: FontWeight.bold),),
                          selectedPages.length < 1 ? 
                            Text("No Bookmarks Set Yet !", style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w200, color: Colors.grey[400] ))
                            :
                            Container( 
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: _getBookmarks() ,
                            )
                            ,
                          
                          
                        ]
                        ),
                    ),
                  
                ),
          ),
      body: NestedScrollView(
        headerSliverBuilder: (context , innerBOx){
          return [
            
            SliverAppBar(
              leading: Container() ,
              expandedHeight: height,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background:Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/cover.jpg'),
                        fit: BoxFit.cover
                      ) ,
                    ),
                  ),
              ),
            )



          ];
        },
        body:FutureBuilder(
              future: loadAsset(context),
              builder: (constext , s){
                if(s.hasData){
                  // print(s.data.split("## BNBC 2015 FINAL DRAFT").length);
                  list = s.data.split('#######NEWPAGE');
                  text = list[0];




                  return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10 ),
                      controller: _scrollController,
                      itemCount: list.length,
                      itemBuilder: (context ,  index){
                          currentPage = index ;
                          print(index);
                      
                        return Container(
                          height: height,
                          padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15  ),
                          child: RichText(textScaleFactor: 1,
                               
                              text:searchMatch(
                                  list[index],
                                  ),
                              ),
                        );



                         

                      },
                    );


                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
                

              },
              
            ),
      
      ),
      
      
      
      // Scrollbar(
      //   child:  FutureBuilder(
      //         future: loadAsset(context),
      //         builder: (constext , s){
      //           if(s.hasData){
      //             // print(s.data.split("## BNBC 2015 FINAL DRAFT").length);
      //             list = s.data.split('#######NEWPAGE');
      //             text = list[0];




      //             return ListView.builder(
      //                 padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10 ),
      //                 controller: _scrollController,
      //                 itemCount: list.length,
      //                 itemBuilder: (context ,  index){
      //                     currentPage = index ;
      //                    // print(index);
      //                 //render image 
      //                 // if(index  < 0 ){
      //                 //   return Container(
      //                 //       height: height,
      //                 //       decoration: BoxDecoration(
      //                 //         image: DecorationImage(
      //                 //           image: AssetImage('assets/cover.jpg'),
      //                 //           fit: BoxFit.cover
      //                 //         ) ,
      //                 //       ),
      //                 //     ) ;
      //                 // } else {
      //                   return Container(
      //                     height: height,
      //                     padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15  ),
      //                     child: RichText(textScaleFactor: 1,
                               
      //                         text:searchMatch(
      //                             list[index],
      //                             ),
      //                         ),
      //                   );
      //                 // }


                         

      //                 },
      //               );


      //           }else{
      //             return Center(child: CircularProgressIndicator(),);
      //           }
                

      //         },
              
      //       )
            
             
            
            
      
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

            if(selectedPages.contains(currentPage)){
              // do nothing
            }else{
              setState(() {
                  selectedPages.add(currentPage);
                  
              });
              _writeBookmarks();
            }
                
                // print(selectedPages);
            },
            child: Icon(Icons.bookmark),
            backgroundColor: Colors.blue,
      ),
    );
  }
}
