import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf_maker/controller/homeController.dart';
import 'package:pdf_maker/utils/nativebig.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/apiController.dart';
import '../controller/imgtopdfController.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  IMGtoPDFController imgtopdfController = Get.put(IMGtoPDFController());
  ApiController apiController = Get.put(ApiController());
  HomeController homeController = Get.put(HomeController());
  var box = GetStorage();


  _launchURLApp() async {
    var url = Uri.parse("");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            // height: MediaQuery.of(context).size.height * 0.10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "asset/logo.png",
                      fit: BoxFit.cover,
                    )),
                // SizedBox(
                //   height: 15,
                // ),
                Column(
                  children: [
                    Text(
                      "All Document",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.sp,),
                    ),
                    Text(
                      "Reader and Maker",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.sp,),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Divider(),
          InkWell(
            onTap: () {
              Get.toNamed('/language');
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'language'.tr,
                      style: TextStyle(fontSize: 17),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (imgtopdfController.theme.value == true) {
                imgtopdfController.theme.value = false;
                box.write('theme', imgtopdfController.theme.value);
              } else {
                imgtopdfController.theme.value = true;
                box.write('theme', imgtopdfController.theme.value);
              }
              Get.changeThemeMode(
                box.read('theme') == true
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'theme'.tr,
                      style: TextStyle(fontSize: 17),
                    ),
                    Icon(
                        Get.isDarkMode ? Icons.dark_mode : Icons.light_mode)
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _launchURLApp();
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Privacy Policy'.tr,
                      style: TextStyle(fontSize: 17),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ),
          NativeBigScreen(),
        ],
      ),
    );
  }

}
