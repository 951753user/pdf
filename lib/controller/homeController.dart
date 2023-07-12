import 'dart:async';
import 'dart:io' as io;
import 'package:external_path/external_path.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

class HomeController extends GetxController {
  RxInt navindex = 0.obs;

  void index(int i) {
    navindex.value = i;
    update();
  }



  RxList filessort = [].obs;

  Future<List<io.FileSystemEntity>> dirContents(io.Directory dir) {
    var files = <io.FileSystemEntity>[];
    var completer = Completer<List<io.FileSystemEntity>>();
    var lister = dir.list(recursive: false);

    lister.listen((file) async {
      io.FileStat f = file.statSync();
      if (f.type == io.FileSystemEntityType.directory) {
        await dirContents(io.Directory(file.uri.toFilePath()));
      } else if (f.type == io.FileSystemEntityType.file &&
          file.path.endsWith('.pdf') ||
          file.path.endsWith('.docx') ||
          file.path.endsWith('.xlsx') ||
          file.path.endsWith('.pptx') ||
          file.path.endsWith('.txt')) {
        filessort.add(file);
      }
    }, onDone: () {
      completer.complete(files);
      update();
    });

    return completer.future;
  }

  void hgjk() async {
    final path = (await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOCUMENTS));

    io.Directory dir = io.Directory('$path/PDF maker/');
    var files = await dirContents(dir);
    print(files);
    update();
  }


  io.File file = io.File("");


  void openPDF(int index) async {
    // final path = (await ExternalPath.getExternalStoragePublicDirectory(
    //     ExternalPath.DIRECTORY_DOWNLOADS));

    String name = basename(filessort[index].toString());

    file = io.File(filessort[index].path);
    // file = io.File("/storage/emulated/0/Download/$name");

    print(
        "***********************************************************************$name");
    print(
        "***********************************************************************$file");

    PdftronFlutter.openDocument(file.path);


    // Get.to(PdfView(file: file));
  }


}