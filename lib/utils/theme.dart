import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/controller/imgtopdfController.dart';
import 'package:sizer/sizer.dart';

class themedata{
  static ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      colorSchemeSeed: Colors.green.shade500,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade500
      )
  );

  static ThemeData light = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      colorSchemeSeed: Colors.green.shade500,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade500
      )
  );
}


IMGtoPDFController imGtoPDFController = Get.put(IMGtoPDFController());


Widget icon(String name)
{
  return SizedBox(
      height: 13.h,
      width: 13.w,
      child: Image.asset("asset/$name"),
  );
}

List month = [
  '',
  "Jan",
  "Feb",
  'March',
  'April',
  'May',
  'June',
  'July',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];