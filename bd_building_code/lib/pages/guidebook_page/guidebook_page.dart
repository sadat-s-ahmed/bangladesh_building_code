import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

Color backgroundColor = Colors.grey.shade200;
Color bg_grad = Color.fromRGBO(58, 58,58,1);
Color bg_grad2 = Color.fromRGBO(58, 58, 58,.7);

Color appbarColor = Colors.black;
class GuidebookPage extends StatefulWidget {
  @override
  _GuidebookPageState createState() => _GuidebookPageState();
}

class _GuidebookPageState extends State<GuidebookPage> {
//  String assetsPDFpath =  '';
//  String urlPDFPath = ''; 
//  bool pdfReady = false ;
//  int _totalPages =  0;
//  int _currentPages = 0;
//  PDFViewController _pdfViewController;
String bnbc = 'https://pdfhost.io/v/jhSyHvvWM_BNBC_2015_FINAL_DRAFT_PART1convertedpdf.pdf';
  @override
  void initState() {
    super.initState();
    // getFileFromAsset('assets/BNBC.pdf')
    //   .then((f){
    //     setState((){
    //       assetsPDFpath = f.path;
    //       pdfReady = true;
    //     });
    //     print(assetsPDFpath);
    //   });
  }
 
//  Future<File> getFileFromAsset(String asset) async {
//     try {

//       var data = await rootBundle.load(asset);
//       var bytes= data.buffer.asUint8List();
//       var dir = await getApplicationDocumentsDirectory();
//       File file = new File("${dir.path}/BNBC.pdf");
//       File assetFile = await file.writeAsBytes(bytes);
//       return assetFile ;

//     } catch (e) {
//       throw Exception('Error Loading asset file');
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(60.0),
            child: AppBar(
            backgroundColor:appbarColor ,
            elevation: 0.0,
            centerTitle: true,
            title: new Text(
                'Guide Books',
                style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.white
                     ),
              ),
          ),
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white),
        child: Stack(
        children: <Widget>[
          // HomePageBar(height: 260.0, title: "Bangladesh Building Code"),
          Positioned.fill(
            top: MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    borderOnForeground: true,
                  
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: new BorderRadius.all(Radius.circular(15.0))
                        ),
                      child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Pdfviewer(title: 'BNBC',url: 'assets/BNBC.pdf',)),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                    width: 1.0, 
                                    color: Colors.black87))),
                          child: Image.asset(
                              'assets/home/buildings.png',
                              height: 35,
                              width: 35,
                              fit: BoxFit.fitWidth,
                          ),
                        ),
                        title: Text(
                          'BNBC ',
                          style: TextStyle(
                            color: Colors.black87, 
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                            ),
                        ),
                        trailing:
                            Icon(Icons.keyboard_arrow_right, color: Colors.black87, size: 30.0),
                      ),
                    ),
                    ),
                  ) ,

                  Card(
                    elevation: 8.0,
                    borderOnForeground: true,
                  
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: new BorderRadius.all(Radius.circular(15.0))
                        ),
                      child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Pdfviewer(title: 'Imarat Nirman Bidhimala',url: 'assets/imarat_nirman.pdf',)),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                    width: 1.0, 
                                    color: Colors.black87))),
                          child: Image.asset(
                              'assets/home/notebook.png',
                              height: 35,
                              width: 35,
                              fit: BoxFit.fitWidth,
                          ),
                        ),
                        title: Text(
                          'Imarat Nirman Bidhimala ',
                          style: TextStyle(
                            color: Colors.black87, 
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                            ),
                        ),
                        trailing:
                            Icon(Icons.keyboard_arrow_right, color: Colors.black87, size: 30.0),
                      ),
                    ),
                    ),
                  )
                  ,

                  Card(
                    elevation: 8.0,
                    borderOnForeground: true,
                  
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: new BorderRadius.all(Radius.circular(15.0))
                        ),
                      child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Pdfviewer(title:'Daag',url: 'assets/daag.pdf' )),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                    width: 1.0, 
                                    color: Colors.black87))),
                          child: Image.asset(
                              'assets/home/contract-1.png',
                              height: 35,
                              width: 35,
                              fit: BoxFit.fitWidth,
                          ),
                        ),
                        title: Text(
                          'Daag ',
                          style: TextStyle(
                            color: Colors.black87, 
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                            ),
                        ),
                        trailing:
                            Icon(Icons.keyboard_arrow_right, color: Colors.black87, size: 30.0),
                      ),
                    ),
                    ),
                  )
                  
                ],
              ),
            ),
          )
        ],
      )
      ),
    );
  }
}

// PDFDocument book ;
  // bool _isloading = true ;
//  Center(
//           child: _isloading 
//                 ? Center(child: CircularProgressIndicator(),)
//                 : PDFViewer(document: this.book)
//         )

 // _loadPDF() async{
  //   PDFDocument doc = await PDFDocument.fromURL('https://www.ets.org/Media/Tests/GRE/pdf/gre_research_validity_data.pdf');
  //   this.setState((){
  //     book = doc;
  //     _isloading = false;
  //   });
  

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
      body: Center(
          child: PdfDocumentLoader(
            assetName: widget.url,
            documentBuilder: (context, pdfDocument, pageCount) => LayoutBuilder(
              builder: (context, constraints) => ListView.builder(
                itemCount: pageCount,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(margin),
                  padding: EdgeInsets.all(padding),
                  color: Colors.black12,
                  child: PdfPageView(
                    pdfDocument: pdfDocument,
                    pageNumber: index + 1,
                    // calculateSize is used to calculate the rendering page size
                    calculateSize: (pageWidth, pageHeight, aspectRatio) =>
                      Size(
                        constraints.maxWidth - wmargin,
                        (constraints.maxWidth - wmargin) / aspectRatio)
                  )
                )
              )
            ),
          )
        )
      );

  
  }
}



  // return Scaffold(
  //     appBar: AppBar(
  //       centerTitle: true,
  //       backgroundColor: Colors.white,
  //       title: Text('Building Code Book' ,
  //         style: TextStyle(color: Colors.black),
  //         ),
  //         leading: IconButton(
  //           icon: Icon(
  //             Icons.arrow_back_ios,
  //             color: Colors.blueAccent,
  //           ),
  //           onPressed: (){
  //             Navigator.pop(context);
  //           },
  //         ),
  //     ),
  //     body:Stack(
  //       children: <Widget>[
  //         !pdfReady ? 
  //           Center(child: CircularProgressIndicator(),) : 
  //           PDFView(
  //           filePath: assetsPDFpath,
  //           autoSpacing: true,
  //           enableSwipe: true,
  //           swipeHorizontal: true,
  //           onError: (e){print(e);},
  //           onRender: (_pages){
  //             setState(() {
  //              _totalPages = _pages;
                
  //             });
  //           },
  //           onViewCreated: (PDFViewController vc){
  //             _pdfViewController = vc;
  //           },
  //           onPageChanged: (int page , int total){
  //             setState(() {
                
  //             });
  //           },
  //         )
  //       ],
  //     ),
  //     floatingActionButton: Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
  //         _currentPages >0 ? 
  //           FloatingActionButton.extended(
  //             backgroundColor: Colors.red,
  //             label:Text("Page ${_currentPages-1}"),
  //             onPressed: (){
  //               _currentPages -= 1;
  //               _pdfViewController.setPage(_currentPages);
  //               print(_pdfViewController.toString());
  //             },
  //           ) :
  //           Offstage(),
  //           _currentPages < _totalPages ? 
  //           FloatingActionButton.extended(
  //             backgroundColor: Colors.green,
  //             label:Text("Page ${_currentPages + 1}"),
  //             onPressed: (){
  //               _currentPages += 1;
  //               _pdfViewController.setPage(_currentPages);
  //               print(_pdfViewController.toString());
  //             },
  //           ) :
  //           Offstage(),

  //       ],
  //     ),
  //   );
  // }