import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:device_info/device_info.dart';

Color appbarColor = Colors.black;

class Pdfviewer extends StatefulWidget {
  final String url ;
  final String title ;
  Pdfviewer({Key key, this.url , this.title}) : super(key: key);

  _PdfviewerState createState() => _PdfviewerState();
}

class _PdfviewerState extends State<Pdfviewer> {
  static const scale = 100.0 / 72.0;
  static const margin = 4.0;
  static const padding = 1.0;
  static const wmargin = (margin + padding) * 2;

final pageController = PageController(
  initialPage: 0 ,
);
List bookmarked = [];
int listnums ;
String v ;
@override
void initState() { 
  super.initState();
  
  if(widget.title == 'Imarat Nirman Bidhimala'){
    v = 'bookmarkN';
  }
  if(widget.title == 'Daag') {
    v = 'bookmarkD';
  }
  _getBookmarks();
}

__getChapters(){
  List<Widget> arr  = new List<Widget>() ;
  var a =[] ; 
  if(v == 'bookmarkN' ){
     a  = [0,7,21,25,29,52,56,61];
  } 
  if(v == 'bookmarkB') {
     a  = [ 0,1]  ;
  }

  for(int i = 0 ; i < a.length ; i++ ){
      arr.add(
          ListTile(
            title: new Text("Chapter $i"),
            onTap: () {
              setState(() {
                  pageController.jumpToPage(a[i]);
              });
            })
        );
    }

    return ListView(
    shrinkWrap: true ,
    children: arr ,
  ) ;
}


_getBookmarks() async{ 
  final bookmarks = new FlutterSecureStorage();

  
  String s = await bookmarks.read(key: v);
  if(s != null ){
    s.split(',').forEach((a){
        int i = int.parse(a);
        bookmarked.add(i);
    });
  }
  
}

_writeBookmarks() async{
  String s  = "";
  bookmarked.forEach((a){
    s += "$a," ;
  });
  final bookmarks = new FlutterSecureStorage();
  bookmarks.delete(key: v);
  await bookmarks.write(key: v, value: s );

}


  Widget build(BuildContext context) {
    return Scaffold(
          appBar:PreferredSize(
          preferredSize: Size.fromHeight(60.0),
            child: AppBar(
            backgroundColor:appbarColor ,
            elevation: 0.0,
            centerTitle: true,
            title: new Text(
                '${widget.title}',
                style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.white
                     ),
              ),
          ),
      ) ,
      drawer:  Drawer(
        child:FutureBuilder<PDFDocument>(
            future: _getDocument(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                int v = bookmarked.length;
                List<Widget> list =  new List<Widget>();
                for(var i = 0  ; i< v ;i++){
                  int y = bookmarked[i] ;
                  list.add(
                    ListTile(
                      title: new Text("Page $y"),
                      onTap: () {
                        setState(() {
                            pageController.jumpToPage(y);
                        });
                      })
                  );

                }
                 Widget  l = ListView(
                    shrinkWrap: true ,
                    children: list ,
                  ) ;
                return SafeArea(
                    child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            
                            color:Colors.white,
                            child: new UserAccountsDrawerHeader(
                              accountName: new Text(widget.title == null ? "" : widget.title),
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
                          Text("Chapters", style: TextStyle(fontSize: 25 ,fontWeight: FontWeight.bold),),
                          Container( 
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(left: 25),
                              child: __getChapters(),
                            ),
                          

                          Padding(
                            padding: EdgeInsets.all(20),
                          ) ,
                          Text("Bookmarked Pages", style: TextStyle(fontSize: 25 ,fontWeight: FontWeight.bold),),
                          bookmarked.length < 1  ? 
                           Text("No Bookmarks Set Yet !", style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w200, color: Colors.grey[400] ))
                            :
                            Container( 
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(left: 25),
                              child: l,
                            )
                             ,
                        ]
                        ),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'chole nah/',
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          )
          ) ,
      body: FutureBuilder<PDFDocument>(
            future: _getDocument(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
              
                listnums = snapshot.data.pagesCount ;
                
                return PDFView(
                  controller: pageController,
                  renderer: (PDFPage page) => page.render(
                    width: page.width * 2,
                    height: page.height * 2,
                    format: PDFPageFormat.JPEG,
                    backgroundColor: '#ffffff',
                  ),
                  document: snapshot.data,
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'chole nah/',
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
                print(pageController.page.ceil());
                bookmarked.add(pageController.page.ceil());
                _writeBookmarks();
            },
            child: Icon(Icons.bookmark),
            backgroundColor: Colors.blue,
          ),
        
      
      
      
      
      
      // Center(
      //     child: PdfDocumentLoader(
      //       assetName: widget.url,
      //       documentBuilder: (context, pdfDocument, pageCount) => LayoutBuilder(
      //         builder: (context, constraints) => ListView.builder(
      //           itemCount: pageCount,
      //           itemBuilder: (context, index) => Container(
      //             margin: EdgeInsets.all(margin),
      //             padding: EdgeInsets.all(padding),
      //             color: Colors.black12,
      //             child: PdfPageView(
      //               pdfDocument: pdfDocument,
      //               pageNumber: index + 1,
      //               // calculateSize is used to calculate the rendering page size
      //               calculateSize: (pageWidth, pageHeight, aspectRatio) =>
      //                 Size(
      //                   constraints.maxWidth - wmargin,
      //                   (constraints.maxWidth - wmargin) / aspectRatio)
      //             )
      //           )
      //         )
      //       ),
      //     )
      //   ),
      
      );

  
  }
  Future<bool> _hasSupportPdfRendering() async {
    final deviceInfo = DeviceInfoPlugin();
    bool hasSupport = false;
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      hasSupport = int.parse(iosInfo.systemVersion.split('.').first) >= 11;
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      hasSupport = androidInfo.version.sdkInt >= 21;
    }
    return hasSupport;
  }

 Future<PDFDocument> _getDocument() async {
    if (await _hasSupportPdfRendering()) {
      return PDFDocument.openAsset(widget.url);
    } else {
      throw Exception(
        'PDF Rendering does not '
        'support on the system of this version',
      );
    }
  }


}
