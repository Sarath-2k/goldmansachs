import 'package:goldmansachs/screens/pdf_viewer.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' as material;
import 'package:intl/intl.dart' as intl;

import '../order_model.dart';

reportView(context) async {
  List<List<String>> orderTable = [
    ['Item Code', 'Category', 'Weight', 'Size', 'Quantity']
  ];
  finalOrder.orderItems.forEach((element) {
    var tableRowList = <String>[
      element.product.itemCode,
      element.product.category,
      element.orderWeight,
      element.orderSize,
      element.orderQuantity.toString(),
    ];
    orderTable.add(tableRowList);
  });

  pdf.addPage(
    MultiPage(
      pageFormat:
          PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: const BoxDecoration(
                border:
                    BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text('order ${finalOrder.orderID}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
        Header(
            level: 1,
            child: Text('order ${finalOrder.orderID}', textScaleFactor: 2)),
        Padding(padding: const EdgeInsets.all(12)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Paragraph(
            //         text: finalOrder.partyName,
            //         style:
            //             TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            //     Paragraph(
            //         text:
            //             '${finalOrder.partyCity} \n${finalOrder.partyContact}',
            //         style:
            //             TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
            //   ],
            // ),
            Paragraph(
                text:
                    'Order date: ${intl.DateFormat('dd/MM/yyyy').format(finalOrder.orderDate)}'
                    '\nOrder ID: ${finalOrder.orderID}'
                    '\n\nDue on: ${intl.DateFormat('dd/MM/yyyy').format(finalOrder.orderDueDate)}',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
          ],
        ),
        Padding(padding: const EdgeInsets.all(30)),
        Table.fromTextArray(context: context, data: orderTable),
        Column(
            children: finalOrder.orderItems
                .map(
                  (orderItem) => Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(32),
                                child: Image(
                                  orderItem.pdfImage,
                                  height: 300,
                                  width: 300,
                                ),
                              )
                            ]),
                        Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 240,
                                child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Item code: ${orderItem.product.itemCode}\n\n',
                                          style: TextStyle(fontSize: 16)),
                                      Text(
                                          'Category: ${orderItem.product.category}\n\n',
                                          style: TextStyle(fontSize: 16)),
                                    ]),
                              ),
                              Container(
                                width: 200,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Size: ${orderItem.orderSize}\n\n',
                                          style: TextStyle(fontSize: 16)),
                                      Text(
                                          'Weight: ${orderItem.orderWeight}g\n\n',
                                          style: TextStyle(fontSize: 16)),
                                    ]),
                              ),
                            ]),
                        Text(
                            '\nDescription: ${orderItem.product.description}\n\n\n',
                            style: TextStyle(fontSize: 16)),
                        Text('Seal: ${orderItem.orderMarkings}\n\n',
                            style: TextStyle(fontSize: 16)),
                        Text('Notes: ${orderItem.orderNote}',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                )
                .toList()),
      ],
    ),
  );
  //save PDF

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/reportOne.pdf';
  print(path);

  File file = File(path);
  file.exists().then((value) async {
    if (value) {
      file.delete();
      file = File(path);
      print('$value - deleting');
      await file.writeAsBytes(pdf.save());
      material.Navigator.of(context).push(
        material.MaterialPageRoute(
          builder: (_) => PdfViewerPage(path: path),
        ),
      );
      pdf = Document();
    } else {
      await file.writeAsBytes(pdf.save());
      material.Navigator.of(context).push(
        material.MaterialPageRoute(
          builder: (_) => PdfViewerPage(path: path),
        ),
      );
      pdf = Document();
    }
  });
}
