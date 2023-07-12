import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';

class AllController extends GetxController {
  RxList files = [].obs;

  Future<List<FileSystemEntity>> dirContents(Directory dir) {
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: false);

    lister.listen((file) async {
      FileStat f = file.statSync();
      if (f.type == FileSystemEntityType.directory) {
        await dirContents(Directory(file.uri.toFilePath()));
      } else if (f.type == FileSystemEntityType.file &&
          file.path.endsWith('.pdf')) {
        files.add(file);
      }
    }, onDone: () {
      completer.complete(files);
      update();
    });

    return completer.future;
  }

  void findfiles() async {
    Directory dir = Directory('/storage/emulated/0');
    var files = await dirContents(dir);
    print(files);
  }
}
