import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {

  final File file;

  const PdfView({Key? key, required this.file}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}


class _PdfViewState extends State<PdfView> {

  @override
  void initState() {
    // TODO: implement initState
    print("===============================================================================================${widget.file.path}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    return WillPopScope(
      onWillPop: ()async{
        Navigator.popUntil(context, ModalRoute.withName('/doc'),);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.popUntil(context, ModalRoute.withName('/doc'),);
          },icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text(name),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        // body: PdftronFlutter.openDocument(widget.file.path),
        body:
        // WebView(
        //   initialUrl: 'https://docs.google.com/gview?embedded=true&url=http://www.africau.edu/images/default/sample.pdf',
        // )
         SfPdfViewer.file(File(widget.file.path),enableDoubleTapZooming: true,enableTextSelection: true,),
      ),
    );
  }
}
