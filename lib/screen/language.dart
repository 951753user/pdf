import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  var box = GetStorage();

  List languageList = ['English',
    'Arabic (عربي)',
    'Chinese (中國人)',
    'Dutch (Nederlands)',
    'French (Français)',
    'Germany (Deutschland)',
    'Gujarati (ગુજરાતી)',
    'Hindi (हिंदी)',
    'Italy (Italia)',
    'Indonesian (bahasa Indonesia)',
    'Japanese (日本)',
    'Korean (한국인)',
    'portuguese (Português)',
    'Russian (Русский)',
    'Spanish (Español)',
    'Tamil (தமிழ்)',
    'Telugu (తెలుగు)',
    'Urdu (اردو)',
  ];

  List languagecode = ['en','ar','cn','dt','fr','gr','gu','hi','it','in','ja','ko','po','ru','sp','tm','tl','ur'];
   List countrycode = ['US','AF','CH','DU','FR','GR','IN','IN','IT','ID','JP','KR','PO','RS','SP','IN','IN','UR'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("language".tr),
      ),
      body: ListView.separated(itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            var locale = Locale(languagecode[index],countrycode[index]);
            Get.updateLocale(locale);
            box.write('language', languagecode[index]);
            box.write('country', countrycode[index]);

            print("language: ${box.read('language')}\n Country: ${box.read('country')}");

            Get.back();
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.08,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(languageList[index],style: TextStyle(fontSize: 16.sp),),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        );
      }, separatorBuilder: (_,__)=>Divider(), itemCount: languageList.length),
    );
  }
}
