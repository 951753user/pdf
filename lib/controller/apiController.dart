import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:http/http.dart' as http;

import '../model/adsModel.dart';

class ApiController extends GetxController {
  // Future<dynamic> adsApi() async {
  //   String apiurl = "https://unisoftex.com/NB/testadsads.json";
  //   var responce = await http.get(Uri.parse(apiurl));
  //
  //   var result = json.decode(responce.body);
  //   if (responce.statusCode == 200) {
  //     // return result;
  //     print("==============done");
  //   } else {
  //     print("============error");
  //   }
  //   return AdsModel.fromJson(result);
  // }

  // https://unisoftex.com/NB/com.videodownloader.nb.json
  // RxString filedata = "".obs;

  // ApiController apicontroller = Get.put(ApiController());
  InterstitialAd? interstitialAd;
  InterstitialAd? interstitialAdplay;
  int adCounter = 0;
  bool check = false;
  bool checkplay = false;
  RxInt appopenattempt =0.obs;
  RewardedAd? rewardAd;
  // RxInt click = 0.obs;

  int interstitialLoadAttempts = 0;
  int maxAttempts = 3;

  initreward() {
    RewardedAd.load(
        adUnitId: "ca-app-pub-3940256099942544/5224354917",
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          print("=======================================================================================================Reward Loaded");
          rewardAd = ad;
            isloading = true;
        }, onAdFailedToLoad: (error) {
          print("Reward not Loaded");
        }));
  }

  // void onAdLoaded(InterstitialAd ad) {
  //   check = true;
  //   interstitialAd = ad;
  //   interstitialLoadAttempts = 0;
  //
  //   interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdDismissedFullScreenContent: (ad) {
  //       interstitialAd!.dispose();
  //       initAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (ad, error) {
  //       interstitialAd!.dispose();
  //       initAd();
  //     },
  //   );
  // }



  // void initAd() async {
  //   // var responce = await adsApi();
  //   InterstitialAd.load(
  //     adUnitId: "ca-app-pub-3940256099942544/1033173712",
  //
  //     request: const AdRequest(),
  //
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: onAdLoaded,
  //       onAdFailedToLoad: (error) {
  //         interstitialLoadAttempts++;
  //         interstitialAd = null;
  //
  //         if (interstitialLoadAttempts <= maxAttempts) {
  //           initAd();
  //         }
  //       },
  //
  //     ),
  //   );
  //
  // }

  void onAdLoadedplay(InterstitialAd ad) {
    checkplay = true;
    interstitialAdplay = ad;
    interstitialLoadAttempts = 0;

    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(

      onAdDismissedFullScreenContent: (ad) {
        interstitialAd!.dispose();
        initAdplay();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        interstitialAd!.dispose();
        initAdplay();
      },

    );
  }

  void initAdplay() async {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoadedplay,
        onAdFailedToLoad: (error) {
          interstitialLoadAttempts++;
          interstitialAd = null;

          if (interstitialLoadAttempts <= maxAttempts) {
            initAdplay();
          }
        },
      ),
    );
  }

  late BannerAd bannerAd;

  late NativeAd nativeAd;
  bool isloading = false;
  AnchoredAdaptiveBannerAdSize? size;


  void bannercall() async {


    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(onAdLoaded: (ad) {
          print(
              "==========================================================================================BANNER LOAD");

          isloading = true;

        }, onAdFailedToLoad: (ad, error) {
          print(
              "-------------------------------------------------------------------------------------------BANNER NOT LOAD");
        }),
        request: const AdRequest());
    bannerAd.load();
  }

  // void getAd() {
  //   if (interstitialAd != null) {
  //     interstitialAd?.show();
  //     interstitialAd = null;
  //   }
  //   adCounter++;
  // }

  @override
  void onInit() {
    // initAd();
    initAdplay();
    super.onInit();
  }

  @override
  void dispose() {
    interstitialAd?.dispose();
    interstitialAdplay?.dispose();
    super.dispose();
  }
}


// ApiController apicontroller = Get.put(ApiController());
// late final InterstitialAd? interstitialAd;
// var interadid;


// setFullScreen(ad) {
//     ad.fullScreenAd = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) {
//         print("=============================AD LODED");
//         ad.dispose();
//         intercall();
//       },
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print(
//           ("=========================AD NOT LOADED"),
//         );
//         ad.dispose();
//         intercall();
//       },
//     );
//     ad.dispose();
//   }

// void intercall() async {
//   var resonce = await apicontroller.adsApi();
//   interadid = resonce.interstitialIdOne;
//   InterstitialAd.load(
//     adUnitId: interadid,
//     request: AdRequest(),
//     adLoadCallback: InterstitialAdLoadCallback(
//       onAdLoaded: (ad) {
//         interstitialAd = ad;

//         setFullScreen(ad);

//         print(
//             "============================================================================== INTERSTITIAL LOADED");
//       },
//       onAdFailedToLoad: (ad) {
//         print("=======================================NOT LODED");
//       },
//     ),
//   );
// }