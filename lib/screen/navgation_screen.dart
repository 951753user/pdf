// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
//
// import 'package:pdf_maker/controller/homeController.dart';
// import 'package:pdf_maker/screen/img_to_pdf.dart';
// import 'package:pdf_maker/screen/list_document.dart';
// import 'package:pdf_maker/screen/show_save_pdf.dart';
//
// import 'createdScreen.dart';
//
// class NavigationScreen extends StatefulWidget {
//   const NavigationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NavigationScreen> createState() => _NavigationScreenState();
// }
//
// class _NavigationScreenState extends State<NavigationScreen> {
//   HomeController homeController = Get.put(HomeController());
//
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   adsController.bannercall();
//   //   super.initState();
//   // }
//   final controller = PersistentTabController(initialIndex: 0);
//
//   List<PersistentBottomNavBarItem> navitem() {
//     return [
//       PersistentBottomNavBarItem(icon: Icon(Icons.description),activeColorPrimary: Colors.green,inactiveColorPrimary: Colors.white,title: "My Files"),
//       PersistentBottomNavBarItem(icon: Icon(Icons.camera_alt_outlined,color: Colors.white,),inactiveIcon: Icon(Icons.camera_alt_outlined,color: Colors.white,),activeColorPrimary: Colors.green,onPressed: (p0) => Navigator.pushNamed(context, '/img_to_pdf'),),
//       PersistentBottomNavBarItem(icon: Icon(Icons.widgets),activeColorPrimary: Colors.green,inactiveColorPrimary: Colors.white,title: "All Files"),
//     ];
//   }
//
//   List<Widget>screen = [
//     Created_Screen(),
//     ImgtoPDF(),
//     DocumentView(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       controller: controller,
//       context,
//       screens: screen,
//       items: navitem(),
//       backgroundColor: Colors.black,
//       navBarStyle: NavBarStyle.style15,
//     );
//   }
// }
//
// /*
// * return Scaffold(
//       body: Obx(()=> screen[homeController.navindex.value]),
//       bottomNavigationBar: Obx(
//           ()=>BottomNavigationBar(
//             backgroundColor: Colors.black,
//             currentIndex: homeController.navindex.value,
//             selectedItemColor: Colors.green,
//             unselectedItemColor: Colors.white,
//             onTap: (int index) {
//               homeController.index(index);
//             },
//             items: [
//               BottomNavigationBarItem(icon: Icon(Icons.description), label: "Docs"),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.widgets), label: "More"),
//             ],
//           ),
//       ),
//     );
// * */
