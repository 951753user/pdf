import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_maker/controller/apiController.dart';
import 'ad_state.dart';
import 'anchored_adaptive_banner_adSize.dart';

class BannerAD extends StatefulWidget {
  const BannerAD({Key? key}) : super(key: key);

  @override
  _BannerADState createState() => _BannerADState();
}

class _BannerADState extends State<BannerAD> {
  BannerAd? banner;

  AnchoredAdaptiveBannerAdSize? size;

  @override
  void initState() {

    Timer(
      const Duration(seconds: 3),
      () => setState(() {}),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bannercall();

    // Initialising adState here because it need context
    // and didChangeDependencies() is called few moments after the state loads its dependencies
    // so context is available at this moment.
    // final adState = Provider.of<AdState>(context);
    //
    // adState.initialization.then((value) async {
    //   // Assigning the size of adaptive banner ad after adState initialization.

    //     }
    //   });
    // });
  }

  ApiController apiController = Get.put(ApiController());

  Future<void> bannercall() async {
    size = await anchoredAdaptiveBannerAdSize(context);

    //
    //   setState(() {
    //     // If adState.bannerAdUnitId is null don't create a BannerAd.
    //     if (adState.bannerAdUnitId != null) {
    banner = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      size: size!,
      listener: BannerAdListener(onAdLoaded: (ad) {
        print(
            "==========================================================================================BANNER LOAD");
      }, onAdFailedToLoad: (ad, error) {
        print(
            "-------------------------------------------------------------------------------------------BANNER NOT LOAD");
      }),
      request: AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    if (banner == null) {
      // Generally banner is null for very less time only until it get assigned in didChangeDependencies.
      // Never think that banner will be null if ads fails loads.
      // To make banner null change the condition in didChangeDependencies or assign null to bannerAdUnitId in AdState().
      return Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text("Ad Space"),
      );
    } else {
      return Container(
        color: AdState.adStatus ? Colors.grey : Colors.transparent,
        width: AdState.adStatus ? size!.width.toDouble() : 0,
        height: AdState.adStatus ? size!.height.toDouble() : 0,
        child: AdState.adStatus
            // If AdState.adStatus is true then ads loads
            // but if its false it will display a empty sizedBox.
            ? AdWidget(
                ad: banner!,
              )
            : Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Text("Ad Space"),
              ),
      );
    }
  }
}
