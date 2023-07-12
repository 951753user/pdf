import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/controller/navigationController.dart';
import 'package:pdf_maker/screen/save_document/save_document.dart';
import 'package:pdf_maker/screen/tabbar_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  var screen = [ShowsavedocumentScreen(), TabbarScreen()];

  NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screen[navigationController.navIndex.value]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationController.navIndex.value,
        onTap: (index) {
          navigationController.changeTabIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.storage), label: 'Storage  '),
        ],
      ),
    );
  }
}
