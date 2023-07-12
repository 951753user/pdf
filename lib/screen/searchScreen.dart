import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:pdf_maker/utils/theme.dart';

import '../controller/apiController.dart';
import 'all_document_view/all/alldocController.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  AllController allController = Get.put(AllController());

  ApiController apicontroller = Get.put(ApiController());

  // var items = [];

  @override
  void initState() {
    // TODO: implement initState

    allController.files.value = allController.filessort;

    apicontroller.initreward();
    allController.hgjk();
    super.initState();
    // print("===================================================================$item");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        // centerTitle: true,
        title: Center(
          child: TextField(
            autofocus: true,
            onChanged: (value) {
              allController.searchdata(value);
            },
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: ' Search...',
              hintStyle: TextStyle(color: Colors.white, fontSize: 18),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => allController.files.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: allController.files.length,
                    itemBuilder: (BuildContext context, int index) {
                      var name = basename(allController.files[index].path);
                      // print("-----------------------------------------=============================================$name");
                      var size = allController.files[index].lengthSync();
                      double sizeinmb = size / (1024 * 1024);
                      double sizeinkb = size / 1024;
                      final stat =
                          FileStat.statSync(allController.files[index].path);
                      return InkWell(
                          onTap: () {
                            // apicontroller.click.value =
                            //     apicontroller.click.value + 1;
                            // print(
                            //     "=========================${apicontroller.click.value}");
                            // if (apicontroller.click.value > 3) {

                            apicontroller.initAdplay();
                            apicontroller.interstitialAdplay!.show().then(
                                (value) => PdftronFlutter.openDocument(
                                    allController.files[index].path));
                            apicontroller.interstitialAdplay = null;
                            // showDialog(
                            //     context: context,
                            //     barrierDismissible: false,
                            //     builder: (ctx) {
                            //       Future.delayed(
                            //           const Duration(milliseconds: 2000),
                            //           () async {
                            //
                            //
                            //         apicontroller.interstitialAdplay = null;
                            //         Get.back();
                            //         // Timer(const Duration(milliseconds: 2800),
                            //         //     () {
                            //         //   allController.openPDF(index);
                            //         // });
                            //       });
                            //       return SizedBox(
                            //         height: 25.h,
                            //         width: 126,
                            //         child: Column(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
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

                            // allController.openPDF(index);

                            // apicontroller.click.value = 0;
                            // }
                            // else if(apicontroller.click.value <=3)
                            // {
                            //   allController.openPDF(index);
                            // }
                          },
                          child: SizedBox(
                            height: 11.h,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  icon("${name.split(".").last}.png"),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 74.w,
                                        child: Text(
                                          basename(
                                              allController.files[index].path),
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
                                      if (name.split(".").last == "txt" ||
                                          name.split(".").last == 'xlsx')
                                        Text(
                                          "${sizeinkb.toStringAsFixed(2)} KB | ${month[stat.modified.month]} ${stat.modified.day}, ${stat.modified.year}",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.grey,
                                            overflow: TextOverflow.ellipsis,
                                            // color: Colors.grey.shade300
                                          ),
                                        )
                                      else
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
                                ],
                              ),
                            ),
                          ));
                    },
                    // separatorBuilder: (context,index){
                    //         if(index%4==2)
                    //           {
                    //          return NativeAdScreen();
                    //           }
                    //         else{
                    //           return Container();
                    //         }
                    // },
                  )
                : Center(
                    child: SizedBox(
                      height: 30.h,
                      width: 60.w,
                      // alignment: Alignment.center,
                      // color: Colors.green,
                      child: Lottie.asset('asset/5451-search-file.json',
                          fit: BoxFit.cover),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
