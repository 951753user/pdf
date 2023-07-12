import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:pdf_maker/screen/all_document_view/pdf/pdfController.dart';
import 'package:pdf_maker/utils/permission.dart';
import 'package:pdf_maker/utils/theme.dart';
import 'package:share_plus/share_plus.dart';

import 'package:sizer/sizer.dart';

import '../../../controller/apiController.dart';

class PDFView extends StatefulWidget {
  const PDFView({Key? key}) : super(key: key);

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  String? directory;
  PdfController pdfController = Get.put(PdfController());
  ApiController apicontroller = Get.put(ApiController());
  bool isSelected = false;
  List selectedfile = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permissiondata();
    pdfController.hgjk();
    //listDir();
  }

  @override
  void dispose() {
    pdfController.filessort.clear();
    super.dispose();
  }

  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  List selectedItem = [];
  bool isMultiSelectionEnabled = false;

// Build Part
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF"),
        centerTitle: isMultiSelectionEnabled ? false : true,
        leading: isMultiSelectionEnabled
            ? IconButton(
            onPressed: () {
              selectedItem.clear();
              isMultiSelectionEnabled = false;
              setState(() {});
            },
            icon: Icon(Icons.close))
            : null,
        actions: [
          Visibility(
            visible: selectedItem.isNotEmpty,
            child: IconButton(
              icon: Icon(Icons.share_rounded),
              onPressed: () {
                selectedItem.forEach((nature) async {
                  // await nature.delete();
                  print(
                      "======================================================================$nature");
                  // ignore: deprecated_member_use
                  // await Share.shareFiles(
                  //     [nature]);
                });
                selectedItem.clear();
                // setState(() {});
              },
            ),
          ),
        ],
      ),
      // backgroundColor: Colors.black,
      body: Obx(
            () => pdfController.filessort.isNotEmpty
            ? ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: pdfController.filessort.length,
          //file.length,
          itemBuilder: (BuildContext context, int index) {
            final name = basename(pdfController.filessort[index].path);
            var size = pdfController.filessort[index].lengthSync();
            double sizeinmb = size / (1024 * 1024);
            final stat =
            FileStat.statSync(pdfController.filessort[index].path);

            return InkWell(
              onTap: () {
                // setState(() {
                //   pdfController.filessort[index].isSelected = !pdfController.filessort[index].isSelected;
                //   if (pdfController.filessort[index].isSelected == true) {
                //     selectedfile.add(pdfController.filessort[index]);
                //     print("=========================================================================$selectedfile");
                //
                //   } else if (pdfController.filessort[index].isSelected == false) {
                //     selectedfile
                //         .removeWhere((element) => element.name == pdfController.filessort[index].name);
                //     print("=========================================================================$selectedfile");
                //   }

                apicontroller.initAdplay();
                apicontroller.interstitialAdplay!.show().then((value) => pdfController.openPDF(index));

                apicontroller.interstitialAdplay = null;
                // });
                // apicontroller.click.value =
                //     apicontroller.click.value + 1;
                // print(
                //     "=========================${apicontroller.click.value}");
                // if (apicontroller.click.value > 3) {

                // showDialog(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (ctx) {
                //       return const Center(
                //           child: CircularProgressIndicator(
                //               color: Color(0xffe52d27)));
                //     });
                // Get.back();

                // apicontroller.initAdplay();
                // apicontroller.interstitialAdplay!
                //     .show()
                //     .then((value) => pdfController.openPDF(index));
                //
                // apicontroller.interstitialAdplay = null;
                // Get.back();
                // if (selectedItem.isEmpty) {
                // } else {
                //   doMultiSelection(pdfController.filessort[index].path);
                // }

                //   apicontroller.click.value = 0;
                // }
                // else if(apicontroller.click.value <=3)
                // {
                //   pdfController.openPDF(index);
                // }
              },
              // onLongPress: () {
              //   isMultiSelectionEnabled = true;
              //   doMultiSelection(pdfController.filessort[index].path);
              // },
              child: SizedBox(
                height: 10.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      icon("${name.split(".").last}.png"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 68.w,
                            child: Text(
                              basename(
                                  pdfController.filessort[index].path),
                              style: TextStyle(
                                fontSize: 14.sp,
                                overflow: TextOverflow.ellipsis,
                                // color: Colors.grey.shade300
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "${sizeinmb.toStringAsFixed(2)} MB | ${month[stat.modified.month]} ${stat.modified.day}, ${stat.modified.year}",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis,
                              // color: Colors.grey.shade300
                            ),
                          )
                        ],
                      ),
                      // SizedBox(
                      //   width: 4,
                      // ),
                      Spacer(),
                      selectedItem.isEmpty
                          ? PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'share',
                              child: Text('Share'),
                            ),

                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            )
                          ];
                        },
                        onSelected: (String value) async {
                          if (value == 'share') {
                            // ignore: deprecated_member_use
                            await Share.shareFiles([
                              pdfController.filessort[index].path
                            ]);
                          } else if (value == 'delete') {
                            pdfController.filessort[index].delete();
                            // setState(() {
                            //   pdfController.hgjk();
                            //
                            //   // PDFView();
                            // });
                            print("--------------------------------------------------------------------${pdfController.filessort[index]}");
                          }
                        },
                      )
                          : Visibility(
                        visible: isMultiSelectionEnabled,
                        child: Icon(
                          selectedItem.contains(pdfController
                              .filessort[index].path)
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          size: 23,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          // separatorBuilder: (context,index){
          //   if(index%4==1)
          //   {
          //     return NativeAdScreen();
          //   }
          //   else{
          //     return Container();
          //   }
          // },
        )
            : Center(
          child: Container(
            height: 30.h,
            width: 60.w,
            // alignment: Alignment.center,
            // color: Colors.green,
            child: Lottie.asset('asset/5451-search-file.json',
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

//   String getSelectedItemCount() {
//     return selectedItem.isNotEmpty
//         ? selectedItem.length.toString() + " item selected"
//         : "No item selected";
//   }
//
// //
//   void doMultiSelection(String nature) {
//     if (isMultiSelectionEnabled) {
//       if (selectedItem.contains(nature)) {
//         selectedItem.remove(nature);
//       } else {
//         selectedItem.add(nature);
//         print(
//             "===============================================================================$selectedItem");
//       }
//       setState(() {});
//     } else {
//       //Other logic
//     }
//   }
}

/*
*
* ListTile(
                      leading: icon("pdf.png"),
                      title: SizedBox(
                        height: 40,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            basename(pdfController.filessort[index].path),
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                // color: Colors.grey.shade300
                            ),
                          ),
                        ),
                      ),
                    ),
*
* */
