import 'dart:io';

import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IMGtoPDFController extends GetxController{

  RxBool theme = false.obs;

  RxList<File> image = <File>[].obs;

  getImageFromCamera(BuildContext context) async {
    final scannedDoc = await DocumentScannerFlutter.launch(context,
        source: ScannerFileSource.CAMERA); // Or ScannerFileSource.GALLERY
    // `scannedDoc` will be the image file scanned from scanner
      if (scannedDoc != null) {
        image.add(File(scannedDoc.path));
        Get.toNamed('/img_to_pdf');
      } else if(image.isEmpty){

        await Get.offNamedUntil('/', (route) => false);

        debugPrint('****************************************************************No image selected');
      }
      update();

  }
}