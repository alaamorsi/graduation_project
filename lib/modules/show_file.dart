import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

class ShowFile extends StatefulWidget {
  final String url;
  const ShowFile({super.key, required this.url});
  @override
  State<ShowFile> createState() => ShowFileState();
}

class ShowFileState extends State<ShowFile> {
  final Completer<PDFViewController> _pdfViewController = Completer<PDFViewController>();
  late PDFViewController shot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondAppbar(context: context, title: "PDF"),
      body: PDF(
        nightMode: !mode,
        autoSpacing: false,
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          shot = pdfViewController;
        },
      ).cachedFromUrl(widget.url),
    );
  }
}
