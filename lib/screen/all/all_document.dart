import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/screen/all/allController.dart';
import 'package:pdf_maker/utils/permission.dart';

class AlldocumentScreen extends StatefulWidget {
  const AlldocumentScreen({super.key});

  @override
  State<AlldocumentScreen> createState() => _AlldocumentScreenState();
}

class _AlldocumentScreenState extends State<AlldocumentScreen> {
  AllController allController = Get.put(AllController());

  @override
  void initState() {
    allController.findfiles();
    permissiondata();
    super.initState();
  }

  @override
  void dispose() {
    allController.files.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemCount: allController.files.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.black,
                child: Text("${allController.files}"),
              ),
            );
          },
        ),
    );
  }
}
