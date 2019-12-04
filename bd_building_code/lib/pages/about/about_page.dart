import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:device_info/device_info.dart';


Color appbarColor = Colors.black;

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

final pageController = PageController(
  initialPage: 0 ,
);

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
            title: new Text(
                'About Us',
                style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.white
                     ),
              ),
          ),
      ),
            body: FutureBuilder<PDFDocument>(
            future: _getDocument(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
              
                return PDFView(
                  controller: pageController,
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
        return PDFDocument.openAsset('assets/ABOUT.pdf');
      } else {
        throw Exception(
          'PDF Rendering does not '
          'support on the system of this version',
        );
      }
    }
}

