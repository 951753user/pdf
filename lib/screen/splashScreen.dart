import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/controller/apiController.dart';
import 'package:pdf_maker/main.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:sizer/sizer.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'list_document.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String image = "asset/logo.png";

  // AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  ApiController apiController = Get.put(ApiController());

  // Future<void> initplatform()async{
  //   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  //
  //   OneSignal.shared
  //       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
  //     setState(() {
  //
  //     });
  //   });
  //
  //
  //   OneSignal.shared
  //       .setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
  //     print('FOREGROUND HANDLER CALLED WITH: ${event}');
  //     /// Display Notification, send null to not display
  //     event.complete(null);
  //
  //     setState(() {
  //
  //     });
  //   });
  //
  //   OneSignal.shared.setAppId("213a0a59-cbc6-48d4-8f98-a16f4faa1bdf");
  //
  //
  //
  // }


  StreamSubscription? dataStream;
  String data = "";
  List<SharedMediaFile>? _sharedFiles;

  @override
  void initState() {
    // initplatform();
    // appOpenAdManager.loadAd();
    // initplatform();

    dataStream = ReceiveSharingIntent.getTextStream().listen((String text) {
      setState(() {
        data = text;
        print(
            "====================================================================$data");
      });
    });
    ReceiveSharingIntent.getInitialText().then((String? text) {
      if (text != null) {
        setState(() {
          data = text;
        });
        var splitpath = data.split('storage');
        filedata = splitpath[1].trim();
      }
    });

    dataStream = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> files) {
      setState(() {
        _sharedFiles = files;
      });
      sharedfile = _sharedFiles!.map((f) => f.path).join(",");

    });

    //Receive files when app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> files) {
      if (files != null) {
        setState(() {
          _sharedFiles = files;
        });
      }
    });

    Timer(const Duration(seconds: 3), () {

      // Get.toNamed('/doc');
      Get.offAll(DocumentView());
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return SizedBox(
      //       height: 300,
      //       width: 300,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           const CircularProgressIndicator(color: Color(0xffe52d27)),
      //           const SizedBox(
      //             height: 25,
      //           ),
      //           DefaultTextStyle(
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 16,
      //             ),
      //             child: const Text(
      //               "Loading Ads..",
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // );
      // appOpenAdManager.showAdIfAvailable();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Timer(const Duration(seconds: 7), () {
    //   if (AppOpenAdManager.appOpenAd != null) {
    //     appOpenAdManager.showAdIfAvailable();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 165,),
          Container(
            child: Image.asset(
              image,
              width: 30.w,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "All Document",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19.sp,
                ),
          ),
          Text(
            "Reader And Maker",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17.sp,
                ),
          ),
          SizedBox(height: 270,),
          Center(child: CircularProgressIndicator(color: Colors.green.shade500,))
        ],
      ),
    );
  }


}

//#e52d27→#b31217
