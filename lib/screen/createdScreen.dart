import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pdf_maker/controller/homeController.dart';
import 'package:sizer/sizer.dart';

import '../controller/apiController.dart';
import '../utils/theme.dart';

class Created_Screen extends StatefulWidget {
  const Created_Screen({Key? key}) : super(key: key);

  @override
  State<Created_Screen> createState() => _Created_ScreenState();
}

class _Created_ScreenState extends State<Created_Screen> {

  String? directory;

  HomeController homeController = Get.put(HomeController());
  ApiController apicontroller = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Created "),
        centerTitle: true,
      ),
      body:
      Obx(
        () => homeController.filessort.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: homeController.filessort.length,
                itemBuilder: (BuildContext context, int index) {
                  var name = basename(homeController.filessort[index].path);
                  var size = homeController.filessort[index].lengthSync();
                  double sizeinmb = size / (1024 * 1024);
                  double sizeinkb = size / 1024;
                  final stat =
                      FileStat.statSync(homeController.filessort[index].path);
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
                                Future.delayed(
                                    Duration(milliseconds: 2000), ()async {
                                  apicontroller.initAdplay();
                                  apicontroller.interstitialAdplay!
                                      .show();

                                  apicontroller.interstitialAdplay = null;
                                  Get.back();
                                  Timer(const Duration(milliseconds: 2500),(){
                                    homeController.openPDF(index);
                                  });
                                });
                                return SizedBox(
                                  height: 25.h,
                                  width: 126,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(color:Color(0xffe52d27)),
                                      SizedBox(height: 25,),
                                      Text(
                                        "Loading Ads..",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });

                        //   apicontroller.click.value = 0;
                        // }
                        // else if(apicontroller.click.value <=3)
                        // {
                        //   homeController.openPDF(index);
                        // }

                      },
                      child: SizedBox(
                        height: 10.h,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              icon("${name.split(".").last}.png"),
                              SizedBox(
                                width: 4.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 74.w,
                                    child: Text(
                                      basename(
                                          homeController.filessort[index].path),
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
                                  if (name.split(".").last == "pdf")
                                    Text(
                                      "${sizeinmb.toStringAsFixed(2)} MB | ${month[stat.modified.month]} ${stat.modified.day}, ${stat.modified.year}",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis,
                                        // color: Colors.grey.shade300
                                      ),
                                    )
                                  else
                                    Text(
                                      "${sizeinkb.toStringAsFixed(2)} KB | ${month[stat.modified.month]} ${stat.modified.day}, ${stat.modified.year}",
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "You don't have any document",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Get.toNamed('/img_to_pdf');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2.0, color: Colors.red),
                      ),
                      child: const Text(
                        "Scan new docs",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
