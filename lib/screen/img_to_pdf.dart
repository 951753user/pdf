import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_maker/controller/homeController.dart';
import 'package:pdf_maker/controller/imgtopdfController.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

class ImgtoPDF extends StatefulWidget {
  @override
  _ImgtoPDFState createState() => _ImgtoPDFState();
}

class _ImgtoPDFState extends State<ImgtoPDF> {
  final picker = ImagePicker();
  final pdf = pw.Document();
  List<File> _image = [];
  TextEditingController txtname = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  IMGtoPDFController imgtopdfController = Get.put(IMGtoPDFController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getImageFromCamera();

  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async {

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("create file name".tr),
            content: Text("are you sure you want to exit".tr),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                color: Colors.green.shade500,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child:  Text("no".tr,style: TextStyle(color: Colors.white),),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/doc', (ModalRoute.withName('/doc')));

                  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  DocumentView(),), (route) => route.isFirst);

                  // Navigator.popUntil(context, ModalRoute.withName('/doc'));
                  homeController.filessort.clear();
                  homeController.hgjk();
                  imgtopdfController.image.clear();
                },
                color: Colors.green.shade500,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child:  Text("yes".tr,style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        );


        return false;
      },
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          // backgroundColor: Colors.black,
          title: const Text(
            "Image to PDF",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.picture_as_pdf,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("create file name".tr),
                    content: TextField(
                      controller: txtname,
                      decoration: InputDecoration(
                        hintText: "file name".tr,
                      ),
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        color: Colors.green.shade500,
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child:  Text("cancel".tr,style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          createPDF();
                          savePDF(txtname.text);
                          homeController.hgjk();
                          homeController.filessort.clear();
                          imgtopdfController.image.clear();
                          Get.back();

                          // Navigator.of(ctx).pop();
                        },
                        color: Colors.green.shade500,
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child:  Text("save".tr,style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
        floatingActionButton: Container(
          height: 65,
          width: 65,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0XFF4CAF50),
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  // shadow color
                  blurRadius: 15,
                  // shadow radius
                  offset: Offset(0, 3),
                  // shadow offset
                  spreadRadius: 0.5,
                  // The amount the box should be inflated prior to applying the blur
                  blurStyle: BlurStyle.normal // set blur style
                  ),
            ],
          ),

          // backgroundColor: Colors.green.shade500,

          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.green.shade500,
            onPressed: () {
              imgtopdfController.getImageFromCamera(context);
            },
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 30,
            ),
          ),
          //const
        ),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       builder: (context) => AlertDialog(
        //         backgroundColor: Colors.white12,
        //         title: Text(
        //           "Select Image",
        //           style: TextStyle(color: Colors.white),
        //         ),
        //         actions: [
        //           ElevatedButton(
        //             onPressed: getImageFromGallery,
        //             child: Text("Gallery"),
        //             style:
        //                 ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500),
        //           ),
        //           ElevatedButton(
        //             onPressed: getImageFromCamera,
        //             child: Text("Camera"),
        //             style:
        //                 ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Obx(
          ()=> imgtopdfController.image != null
              ? ListView.builder(
            itemCount: imgtopdfController.image.length,
            itemBuilder: (context, index) => Container(
              height: 400,
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              child: Image.file(
                imgtopdfController.image[index],
                fit: BoxFit.fill,
              ),
            ),
          )
              : Container(),
        )
      ),
    );
  }

  getImageFromGallery() async {
    final pickedFile = await picker.pickMultiImage();
    setState(() {
      if (pickedFile != null) {
        for(var img in pickedFile)
          {
            imgtopdfController.image.add(File(img.path));
          }
      } else {
        print('No image selected');
      }
    });
  }

  // getImageFromCamera() async {
  //   final scannedDoc = await DocumentScannerFlutter.launch(context,
  //       source: ScannerFileSource.CAMERA); // Or ScannerFileSource.GALLERY
  //   // `scannedDoc` will be the image file scanned from scanner
  //   setState(() {
  //     if (scannedDoc != null) {
  //       _image.add(File(scannedDoc.path));
  //     } else if(_image.isEmpty){
  //
  //         Navigator.popUntil(context, ModalRoute.withName('/'));
  //
  //       print('****************************************************************No image selected');
  //     }
  //   });
  //
  // }

  createPDF() async {
    for (var img in _image) {
      final image = pw.MemoryImage(img.readAsBytesSync());

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          },
        ),
      );
    }
  }

  savePDF(String name) async {
    try {
      final dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOCUMENTS);

      String documentDirectory = Platform.isAndroid
          ? '$dir/PDF maker/'
          : await getApplicationSupportDirectory().then((value) => value.path);
      if (!File(documentDirectory).existsSync()) {

        await Directory(documentDirectory).create(recursive: true);
      }

      final file = File('$documentDirectory/$name.pdf');
      await file.writeAsBytes(await pdf.save());
      showPrintedMessage('success', 'saved to documents');
      // openPDF();
    } catch (e) {
      showPrintedMessage('error', e.toString());
    }
    Get.back();
    Get.back();
  }

  File file = File("");

  void openPDF() async {
    final path = (await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOCUMENTS));

    file = File("$path//PDF maker/${txtname.text}.pdf");

    PdftronFlutter.openDocument(file.path);

    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => PdfView(file: file)));
  }

  showPrintedMessage(String title, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
