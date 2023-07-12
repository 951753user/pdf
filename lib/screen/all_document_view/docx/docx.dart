import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:pdf_maker/screen/all_document_view/docx/docxController.dart';
import 'package:pdf_maker/utils/permission.dart';
import 'package:pdf_maker/utils/theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/apiController.dart';

class DocView extends StatefulWidget {
  const DocView({Key? key}) : super(key: key);

  @override
  State<DocView> createState() => _DocViewState();
}

class _DocViewState extends State<DocView> {
  String? directory;

  var box = GetStorage();

  DocxController docxController = Get.put(DocxController());
  ApiController apicontroller = Get.put(ApiController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permissiondata();
    docxController.hgjk();
  }

  @override
  void dispose() {
    docxController.filessort.clear();
    super.dispose();
  }

// Build Part
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DOCX"),
        centerTitle: true,
      ),
      // backgroundColor: Colors.black,
      body: Obx(
            () => docxController.filessort.isNotEmpty
            ? ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: docxController.filessort.length,
          itemBuilder: (BuildContext context, int index) {
            final name = basename(docxController.filessort[index].path);
            var size = docxController.filessort[index].lengthSync();
            double sizeinmb = size / (1024 * 1024);
            final stat =
            FileStat.statSync(docxController.filessort[index].path);

            return InkWell(
              onTap: () {
                // apicontroller.click.value =
                //     apicontroller.click.value + 1;
                // print(
                //     "=========================${apicontroller.click.value}");
                // if (apicontroller.click.value > 3) {

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) {
                      // Future.delayed(
                      //     Duration(milliseconds: 1000), ()async {
                      apicontroller.initAdplay();
                      apicontroller.interstitialAdplay!.show().then((value) => docxController.openPDF(index));

                      apicontroller.interstitialAdplay = null;
                      // });
                      return SizedBox(
                        height: 25.h,
                        width: 126,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(color:Color(0xffe52d27)),
                          ],
                        ),
                      );

                    });
                // showDialog(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (ctx) {
                //       Future.delayed(const Duration(milliseconds: 2000),
                //           () async {
                //
                //         Timer(const Duration(milliseconds: 2500
                //         ), () {
                //           docxController.openPDF(index);
                //         });
                //       });
                //       return SizedBox(
                //         height: 25.h,
                //         width: 126,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: const [
                //             CircularProgressIndicator(
                //                 color: Color(0xffe52d27)),
                //             SizedBox(
                //               height: 25,
                //             ),
                //             Text(
                //               "Loading Ads..",
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 16,
                //               ),
                //             ),
                //           ],
                //         ),
                //       );
                //     });
                //   apicontroller.click.value = 0;
                // }
                // else if(apicontroller.click.value <=3)
                // {
                //   docxController.openPDF(index);
                // }
              },
              child: Container(
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
                                  docxController.filessort[index].path),
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
                      SizedBox(width: 4,),
                      PopupMenuButton(
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
                        onSelected: (String value)async {
                          if(value == 'share')
                          {

                            // ignore: deprecated_member_use
                            await Share.shareFiles([docxController.filessort[index].path]);

                          }
                          else if(value == 'delete')
                          {

                            docxController.filessort[index].delete();

                          }

                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          // separatorBuilder: (context,index){
          //   if(index%4==0)
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
}

/*
*
*
* ListTile(
                      title: Text(
                        basename(docxController.filessort[index].path),
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            // color: Colors.grey.shade300
                        ),
                      ),
                      leading: icon("docx.png"),
                    ),
*
*
* */
