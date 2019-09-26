import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class GuidebookPage extends StatefulWidget {
  @override
  _GuidebookPageState createState() => _GuidebookPageState();
}

class _GuidebookPageState extends State<GuidebookPage> {
 String assetsPDFpath =  '';
 String urlPDFPath = ''; 
 bool pdfReady = false ;
 int _totalPages =  0;
 int _currentPages = 0;
 PDFViewController _pdfViewController;

  @override
  void initState() {
    super.initState();
    getFileFromAsset('assets/BNBC.pdf')
      .then((f){
        setState((){
          assetsPDFpath = f.path;
          pdfReady = true;
        });
        print(assetsPDFpath);
      });
  }
 
 Future<File> getFileFromAsset(String asset) async {
    try {

      var data = await rootBundle.load(asset);
      var bytes= data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = new File("${dir.path}/BNBC.pdf");
      File assetFile = await file.writeAsBytes(bytes);
      return assetFile ;

    } catch (e) {
      throw Exception('Error Loading asset file');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Building Code Book' ,
          style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blueAccent,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
      ),
      body:Stack(
        children: <Widget>[
          !pdfReady ? 
            Center(child: CircularProgressIndicator(),) : 
            PDFView(
            filePath: assetsPDFpath,
            autoSpacing: true,
            enableSwipe: true,
            swipeHorizontal: true,
            onError: (e){print(e);},
            onRender: (_pages){
              setState(() {
               _totalPages = _pages;
                
              });
            },
            onViewCreated: (PDFViewController vc){
              _pdfViewController = vc;
            },
            onPageChanged: (int page , int total){
              setState(() {
                
              });
            },
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPages >0 ? 
            FloatingActionButton.extended(
              backgroundColor: Colors.red,
              label:Text("Page ${_currentPages-1}"),
              onPressed: (){
                _currentPages -= 1;
                _pdfViewController.setPage(_currentPages);
                print(_pdfViewController.toString());
              },
            ) :
            Offstage(),
            _currentPages < _totalPages ? 
            FloatingActionButton.extended(
              backgroundColor: Colors.green,
              label:Text("Page ${_currentPages + 1}"),
              onPressed: (){
                _currentPages += 1;
                _pdfViewController.setPage(_currentPages);
                print(_pdfViewController.toString());
              },
            ) :
            Offstage(),

        ],
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
  