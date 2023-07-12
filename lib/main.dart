import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_maker/screen/language.dart';
import 'package:pdf_maker/screen/privacypolicy.dart';
import 'package:pdf_maker/screen/searchScreen.dart';
import 'package:pdf_maker/screen/settingScreen.dart';
import 'package:pdf_maker/screen/splashScreen.dart';
import 'package:pdf_maker/screen/txt_create.dart';
import 'package:pdf_maker/screen/img_to_pdf.dart';
import 'package:pdf_maker/screen/list_document.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/screen/show_save_pdf.dart';
import 'package:pdf_maker/utils/localestring.dart';
import 'package:pdf_maker/utils/theme.dart';
import 'package:sizer/sizer.dart';

String? filedata;
String? sharedfile;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await GetStorage.init();

  var box = GetStorage();

  var languagecode = box.read('language');
  var countrycode = box.read('country');

  runApp(
      Sizer(
      builder: ((context,orientation,deviceType){
        return GetMaterialApp(
          translations: LocalString(),
          locale: Locale(languagecode ?? "en",countrycode ?? "US"),
          debugShowCheckedModeBanner: false,
          themeMode: box.read('theme') == true?ThemeMode.dark:ThemeMode.light,
          theme: themedata.light,
          darkTheme: themedata.dark,

          // ThemeData(
          //   brightness: Brightness.dark,
          //   scaffoldBackgroundColor: Colors.black,
          //   colorSchemeSeed: Colors.green,
          //   appBarTheme: AppBarTheme(
          //     backgroundColor: Colors.black
          //   )
          // ),
          // initialRoute: '/privacy',
          routes: {
            '/':(p0) => SplashScreen(),
            '/doc':(p0) => DocumentView(),
            '/set':(p0) => SettingScreen(),
            '/img_to_pdf':(p0) => ImgtoPDF(),
            '/txt_create':(p0) => TxtCreate(),
            '/language':(p0) => LanguageScreen(),
            '/search':(p0) => SearchScreen(),
            '/privacy':(p0) => Privacy(),
          },
        );
      })
    )
  );
}

