import 'package:flutter/material.dart';
import 'package:pdf_maker/utils/permission.dart';

class ShowsavedocumentScreen extends StatefulWidget {
  const ShowsavedocumentScreen({super.key});

  @override
  State<ShowsavedocumentScreen> createState() => _ShowsavedocumentScreenState();
}

class _ShowsavedocumentScreenState extends State<ShowsavedocumentScreen> {
  @override
  void initState() {
    permissiondata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
