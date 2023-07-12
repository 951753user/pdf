import 'package:flutter/material.dart';
import 'package:pdf_maker/screen/all/all_document.dart';
import 'package:pdf_maker/screen/pdf/pdfScreen.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({super.key});

  @override
  State<TabbarScreen> createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Document Reader"),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [Tab(text: "Tab 1"), Tab(text: "Tab 2")],
          ),
        ),
        body: const TabBarView(
          children: [
            AlldocumentScreen(),
            PdfScreen(),
          ],
        ),
      ),
    );
  }
}
