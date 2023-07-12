import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Privacy_Policy extends StatelessWidget {
  const Privacy_Policy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Privacy Policy",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 10,

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("https://sites.google.com/view/documentreder/home"),
          ),
        ),
      ),
    );
  }

  Widget sizebox()
  {
    return SizedBox(height: 15.h,);
  }

  Widget text(String text)
  {
    return Text(text,style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),);
  }
}
