import 'package:get/get.dart';
import 'package:pdf_maker/controller/homeController.dart';
import 'package:permission_handler/permission_handler.dart';

void permissiondata() async {


  HomeController homeController = Get.put(HomeController());

  var status = await Permission.storage.status;
  var status2 = await Permission.manageExternalStorage.status;
  var status3 = await Permission.camera.status;

  if (!status.isGranted) {
    //check each permission status after.
    await Permission.storage.request();
    print("Storage permission is denied.");
  }
  if (!status3.isGranted) {
    //check each permission status after.
    await Permission.camera.request();
    print("Camera permission is denied.");
  }
  if (!status2.isGranted) {
    //check each permission status after.
    await Permission.manageExternalStorage.request();
    print("Storage permission is denied.");
  }
}