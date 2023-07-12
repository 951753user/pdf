import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt navIndex = 0.obs;

  void changeTabIndex(int index) {
    navIndex.value = index;
  }
}
