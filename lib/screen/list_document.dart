import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf_maker/controller/apiController.dart';
import 'package:pdf_maker/controller/imgtopdfController.dart';
import 'package:pdf_maker/main.dart';
import 'package:pdf_maker/screen/all_document_view/all/all.dart';
import 'package:pdf_maker/screen/all_document_view/docx/docx.dart';
import 'package:pdf_maker/screen/all_document_view/pdf/pdf.dart';
import 'package:pdf_maker/screen/all_document_view/ppt/ppt.dart';
import 'package:pdf_maker/screen/all_document_view/txt/txt.dart';
import 'package:pdf_maker/screen/all_document_view/xls/xls.dart';
import 'package:pdf_maker/screen/searchScreen.dart';
import 'package:pdf_maker/screen/settingScreen.dart';
import 'package:pdf_maker/screen/show_save_pdf.dart';
import 'package:pdf_maker/utils/appOpenAdManager.dart';
import 'package:pdf_maker/utils/nativeadscreen.dart';
import 'package:pdf_maker/utils/permission.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:sizer/sizer.dart';

import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../controller/homeController.dart';
import '../utils/banner_ad.dart';
import 'createdScreen.dart';

class DocumentView extends StatefulWidget {
  const DocumentView({Key? key}) : super(key: key);

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView>
    with SingleTickerProviderStateMixin {
  IMGtoPDFController imgtopdfController = Get.put(IMGtoPDFController());
  ApiController apiController = Get.put(ApiController());
  HomeController homeController = Get.put(HomeController());
  var box = GetStorage();
  bool isPaused = false;

  // AppOpenAdManager appOpenAdManager = AppOpenAdManager();

  // StreamSubscription? dataStream;
  // String data = "";
  // String filedata = "";

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
    CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    // appOpenAdManager.loadAd();
    permissiondata();
    // WidgetsBinding.instance.addObserver(this);
    if (filedata != null) {
      PdftronFlutter.openDocument("/storage$filedata");
    }

    if (sharedfile != null) {
      PdftronFlutter.openDocument(sharedfile!);
    }

    // Timer(Duration(seconds: 2),(){
    // if(apiController.filedata.value != null)
    //
    // });

    // dataStream = ReceiveSharingIntent.getTextStream().listen((String text) {
    //   setState(() {
    //     data = text;
    //     print(
    //         "====================================================================$data");
    //   });
    // });
    // ReceiveSharingIntent.getInitialText().then((String? text) {
    //   if (text != null) {
    //     setState(() {
    //       data = text;
    //     });
    //     var splitpath = data.split('root');
    //     filedata = splitpath[1].trim();
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // dataStream!.cancel();
    homeController.filessort.clear();
    // WidgetsBinding.instance.removeObserver(this);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // TODO: implement didChangeAppLifecycleState
  //   super.didChangeAppLifecycleState(state);
  //
  //   if (state == AppLifecycleState.paused) {
  //     isPaused = true;
  //   }
  //   if (state == AppLifecycleState.resumed && isPaused) {
  //     print("Resumed==========================");
  //
  //     // appOpenAdManager.showAdIfAvailable();
  //     isPaused = false;
  //   }
  // }

  void themechange() {
    Get.changeThemeMode(
      box.read('theme') == true ? ThemeMode.dark : ThemeMode.light,
    );
  }

  List name = ["ALL", "PDF", "DOC", "XLS", "PPT", "TXT"];
  List namelist = [
    "ALL Files",
    "PDF Files",
    "DOC Files",
    "XLS Files",
    "PPT Files",
    "TXT Files"
  ];
  List screen = [
    AllDocument(),
    PDFView(),
    DocView(),
    XlsxView(),
    PptView(),
    TxtView(),
  ];
  List photo = [
    "asset/logo.png",
    "asset/pdf.png",
    "asset/docx.png",
    "asset/xlsx.png",
    "asset/pptx.png",
    "asset/txt.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.green.shade500,
          title: const Text("All Documents"),
          // backgroundColor: Colors.black,
          // centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(SettingScreen());
              },
              icon: Icon(Icons.person),
            ),
          ],
        ),
        bottomNavigationBar:  SizedBox(
          height: 58,
          child: BannerAD(),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                // elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(SearchScreen());
                  },
                  child: Container(
                    height: 50,
                    decoration:  const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Row(
                      children:  [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Search Here...".tr,
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        Spacer(),
                        Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 22, right: 22),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Documents Formate".tr,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Spacer(),

                  IconButton(
                      icon: isPaused
                          ? Icon(Icons.grid_view)
                          : Icon(
                        Icons.view_list,
                      ),
                      onPressed: () {
                        setState(() {
                          // Here we changing the icon.
                          isPaused = !isPaused;
                        });
                      }),

                  // IconButton(onPressed: () {
                  //   setState(() {
                  //     isPaused = true;
                  //
                  //     // grid();
                  //   });
                  // }, icon: Icon((isPaused=(true?Icons.grid_view:Icons.view_list) as bool) as IconData?)),
                ],
              ),
            ),
            if(isPaused == true)
              list(),
            if(isPaused == false)
              grid(),
            // NativeAdScreen(),
          ],
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

        //Init Floating Action Bubble
        floatingActionButton: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
            // Floating action menu item
            Bubble(
              title: "Image to PDF",
              iconColor: Colors.white,
              bubbleColor: Colors.green.shade500,
              icon: Icons.picture_as_pdf_outlined,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                imgtopdfController.getImageFromCamera(context);
                _animationController.reverse();
              },
            ),
            // Floating action menu item
            Bubble(
              title: "TXT",
              iconColor: Colors.white,
              bubbleColor: Colors.green.shade500,
              icon: Icons.description,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                Get.toNamed('/txt_create');
                _animationController.reverse();
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () =>
          _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: Colors.white,

          animatedIconData: AnimatedIcons.add_event,
          // Flaoting Action button Icon
          // iconData: Icons.,
          backGroundColor: Colors.green.shade500,
        ));
  }

  Widget grid() {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 2 / 2.2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(screen[index]);
                  },
                  child: Card(
                    // elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        height: 10.h,
                        width: 16.w,
                        decoration: const BoxDecoration(
                          color: Color(0XFFE8F5E9),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(photo[index]),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  name[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3, childAspectRatio: 2 / 2.2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 4, bottom: 4),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(screen[index]);
                  },
                  child: Card(
                    // elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        height: 10.h,
                        width: 16.w,
                        decoration: const BoxDecoration(
                          color: Color(0XFFE8F5E9),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(photo[index]),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  namelist[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
