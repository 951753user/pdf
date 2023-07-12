import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_maker/controller/apiController.dart';
import 'package:sizer/sizer.dart';

class NativeBigScreen extends StatefulWidget {
  const NativeBigScreen({Key? key}) : super(key: key);

  @override
  State<NativeBigScreen> createState() => _NativeBigScreenState();
}

class _NativeBigScreenState extends State<NativeBigScreen> {

  @override
  void initState() {
    // TODO: implement initState
    nativecallbig();
    super.initState();

  }


  @override
  void didChangeDependencies() {
    // nativecall();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: isloading == true
          ? AdWidget(ad: nativeAd)
          : Center(child: Text("Ad Space..",style: TextStyle(color: Colors.black),)),
    );
  }


  late NativeAd nativeAd;
  bool isloading = false;
  ApiController apiController = Get.put(ApiController());
  void nativecallbig() async {
    nativeAd = NativeAd(
      adUnitId: "ca-app-pub-3940256099942544/1044960115",
      factoryId: "listTile",
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          print(
              "==========================================================================================================NATIV AD LOAD");
          setState(
                () {
              isloading = true;
            },
          );
        },
        onAdFailedToLoad: (ad, error) {
          print("$error");
          print(
              "--------------------------------------------------------------------------------------------------------NATIV AD NOT LOAD");
          nativeAd.dispose();
        },
      ),
      request: const AdRequest(),
    );
    nativeAd.load();
  }
}
