import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_maker/controller/homeController.dart';
import 'package:pdf_maker/screen/all_document_view/txt/txtController.dart';
import 'package:pdf_maker/screen/createdScreen.dart';

class TxtCreate extends StatefulWidget {
  const TxtCreate({Key? key}) : super(key: key);

  @override
  State<TxtCreate> createState() => _TxtCreateState();
}

class _TxtCreateState extends State<TxtCreate> {

  TextEditingController txt = TextEditingController();
  TextEditingController filename = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  TxtController txtController = Get.put(TxtController());

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

                  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const DocumentView(),), (route) => route.isFirst);

                  // Navigator.pushAndRemoveUntil(context, ModalRoute.withName('/doc'));
                  homeController.filessort.clear();
                  homeController.hgjk();
                  txtController.filessort.clear();
                  txtController.hgjk();
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
        appBar: AppBar(
          title: const Text("TXT"),
          actions: [
            IconButton(onPressed: (){
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("create file name".tr),
                  content: TextField(
                    controller: filename,
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
                        child: Text("cancel".tr,style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        saveTXT(filename.text);
                        homeController.filessort.clear();
                        homeController.hgjk();
                        txtController.filessort.clear();
                        txtController.hgjk();
                        // Get.to(const Created_Screen());
                        // Navigator.of(ctx).pop();
                      },
                      color: Colors.green.shade500,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child: Text("save".tr,style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              );
            }, icon: const Icon(Icons.save_alt))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: txt,
                    maxLines: 30,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: "enter text".tr,
                      border: InputBorder.none
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  saveTXT(String name) async {
    try {
      final dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOCUMENTS);

      String documentDirectory = Platform.isAndroid
          ? '$dir/PDF maker/'
          : await getApplicationSupportDirectory().then((value) => value.path);
      if (!File(documentDirectory).existsSync()) {
        await Directory(documentDirectory).create(recursive: true);
      }

      final file = File('$documentDirectory/$name.txt');
      await file.writeAsString(txt.text);
      showPrintedMessage('success', 'saved to documents');
      // openPDF();
    } catch (e) {
      showPrintedMessage('error', e.toString());
    }
    Get.back();
    Get.back();
  }

  showPrintedMessage(String title, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

}
