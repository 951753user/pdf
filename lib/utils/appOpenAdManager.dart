// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:pdf_maker/controller/apiController.dart';
//
// import '../screen/list_document.dart';
//
// class AppOpenAdManager {
//   static AppOpenAd? appOpenAd;
//   bool _isShowingAd = false;
//   static bool isLoaded = false;
//   var openid;
//   ApiController apiController = Get.put(ApiController());
//
//   /// Load an AppOpenAd.
//   void loadAd() async {
//     var resonce = await apiController.adsApi();
//     openid = resonce.appOpenIdOne;
//     AppOpenAd.load(
//       adUnitId: openid,
//       orientation: AppOpenAd.orientationPortrait,
//       request: const AdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(
//         onAdLoaded: (ad) {
//           print("Ad Loaded.................................");
//           appOpenAd = ad;
//           isLoaded = true;
//         },
//         onAdFailedToLoad: (error) {
//           // Handle the error.
//         },
//       ),
//     );
//   }
//
//   // Whether an ad is available to be shown.
//   // bool get isAdAvailable {
//   //   return _appOpenAd != null;
//   // }
//
//   void showAdIfAvailable() {
//     print(
//         "Called=====================================================================");
//     if (appOpenAd == null) {
//       print('**************************************************************************Tried to show ad before available.');
//       loadAd();
//       return;
//     }
//     if (_isShowingAd) {
//       print('**************************************************************************Tried to show ad while already showing an ad.');
//       return;
//     }
//
//     // Set the fullScreenContentCallback and show the ad.
//     appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (ad) {
//         _isShowingAd = true;
//         // attempt++;
//         print('$ad onAdShowedFullScreenContent');
//       },
//       onAdFailedToShowFullScreenContent: (ad, error) {
//         print('----------------------------------------------------------------------------------------------------------------------$ad onAdFailedToShowFullScreenContent: $error');
//         _isShowingAd = false;
//         ad.dispose();
//         appOpenAd = null;
//       },
//       onAdDismissedFullScreenContent: (ad) {
//         apiController.appopenattempt.value++;
//
//         if(apiController.appopenattempt.value <= 1)
//           {
//             Get.offAll(DocumentView());
//           }
//         print('$ad onAdDismissedFullScreenContent');
//         _isShowingAd = false;
//         ad.dispose();
//         appOpenAd = null;
//         loadAd();
//       },
//     );
//     appOpenAd!.show();
//   }
// }
