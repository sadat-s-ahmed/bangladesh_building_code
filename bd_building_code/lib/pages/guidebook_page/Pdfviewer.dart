import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';


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
        ),
      
      );

  
  }
}
