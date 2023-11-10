import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
class PDFViewerPage extends StatelessWidget {
  final String pdfAssetPath; // Provide the path to your PDF file

  PDFViewerPage({required this.pdfAssetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: PDFView(
          filePath: pdfAssetPath,
         enableSwipe: true,
  swipeHorizontal: true,
  autoSpacing: false,
  pageFling: false,
          fitPolicy: FitPolicy.BOTH,
        ),
      ),
    );
  }
}
