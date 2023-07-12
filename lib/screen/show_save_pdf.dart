// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:core';
//
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';
// import 'package:pdf_maker/controller/homeController.dart';
// import 'package:pdf_maker/screen/createdScreen.dart';
// import 'package:pdf_maker/utils/permission.dart';
// import 'package:pdf_maker/utils/theme.dart';
// import 'package:sizer/sizer.dart';
//
// import '../controller/apiController.dart';
// import '../utils/banner_ad.dart';
// import '../utils/nativeadscreen.dart';
// import 'all_document_view/all/all.dart';
// import 'all_document_view/docx/docx.dart';
// import 'all_document_view/pdf/pdf.dart';
// import 'all_document_view/ppt/ppt.dart';
// import 'all_document_view/txt/txt.dart';
// import 'all_document_view/xls/xls.dart';
//
// class ShowSavePDFScreen extends StatefulWidget {
//   const ShowSavePDFScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ShowSavePDFScreen> createState() => _ShowSavePDFScreenState();
// }
//
// class _ShowSavePDFScreenState extends State<ShowSavePDFScreen> {
//   String? directory;
//
//   HomeController homeController = Get.put(HomeController());
//   ApiController apicontroller = Get.put(ApiController());
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     permissiondata();
//     // const BannerAD();
//     homeController.hgjk();
//   }
//
//   List name = ["Created", "ALL", "PDF", "DOC", "XLS", "PPT", "TXT"];
//   List screen = [
//     Created_Screen(),
//     AllDocument(),
//     PDFView(),
//     DocView(),
//     XlsxView(),
//     PptView(),
//     TxtView(),
//   ];
//   List photo = [
//     "asset/logo.png",
//     "asset/logo.png",
//     "asset/pdf.png",
//     "asset/docx.png",
//     "asset/xlsx.png",
//     "asset/pptx.png",
//     "asset/txt.png",
//   ];
//
//   @override
//   void dispose() {
//     homeController.filessort.clear();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.red,
//         title: const Text("Document"),
//         // backgroundColor: Colors.black,
//         centerTitle: true,
//       ),
//       bottomNavigationBar: const SizedBox(
//         height: 58,
//         child: BannerAD(),
//       ),
//       body: GridView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: 7,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, childAspectRatio: 3 / 3.5),
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Get.to(screen[index]
//                     );
//                   },
//                   child: Container(
//                       height: 12.h,
//                       width: 20.w,
//                       decoration: const BoxDecoration(
//                         color: Color(0xFFFFEBEE),
//                         borderRadius: BorderRadius.all(Radius.circular(18)),
//                       ),
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Image.asset(photo[index]),
//                         ),
//                       )
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   name[index],
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//
//
//     );
//   }
// }
//
// /*
// *
// * ListTile(
//
//                       title: Text(
//                         basename(homeController.filessort[index].path),
//                         style: const TextStyle(
//                             overflow: TextOverflow.ellipsis,
//                             // color: Colors.grey.shade300
//                         ),
//                       ),
//                       leading: icon("${name.split(".").last}.png"),
//                     ),
// *
// * */
