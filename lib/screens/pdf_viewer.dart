import 'dart:io';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:intl/intl.dart' as intl;

import '../order_model.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              final File file = File(path);
              List<int> fileBytes = file.readAsBytesSync();

              Share.file(
                  finalOrder.orderID, '${finalOrder.orderID}.pdf', fileBytes, 'file/pdf',
                  text:
                      '${finalOrder.orderID} - ${intl.DateFormat('dd/MM/yyyy').format(finalOrder.orderDate)}');
            },
          ),
        ],
      ),
      path: path,
    );
  }
}
