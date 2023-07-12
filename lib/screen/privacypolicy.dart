import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 45.h,
        width: double.infinity,
        color: Colors.red,
        child: Text("All",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
