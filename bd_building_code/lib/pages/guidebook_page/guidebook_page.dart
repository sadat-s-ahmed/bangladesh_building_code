import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class GuidebookPage extends StatefulWidget {
  @override
  _GuidebookPageState createState() => _GuidebookPageState();
}

class _GuidebookPageState extends State<GuidebookPage> {
  PDFDocument book ;
  bool _isloading = true ;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }
  _loadPDF() async{
    PDFDocument doc = await PDFDocument.fromURL('https://www.ets.org/Media/Tests/GRE/pdf/gre_research_validity_data.pdf');
    this.setState((){
      book = doc;
      _isloading = false;
    });
  
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
      ),
      body: Center(
          child: _isloading 
                ? Center(child: CircularProgressIndicator(),)
                : PDFViewer(document: this.book)
        ),
    );
  }
}