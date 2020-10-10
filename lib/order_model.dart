import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:goldmansachs/product.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class FinalOrder {
  String orderID;
  String partyName;
  String partyContact;
  String partyCity;
  DateTime orderDate;
  DateTime orderDueDate;
  List<OrderItem> orderItems;

  FinalOrder({
    @required this.orderID,
    @required this.partyName,
    @required this.partyContact,
    @required this.partyCity,
    @required this.orderDate,
    @required this.orderDueDate,
    @required this.orderItems,
  });
}

class OrderItem {
  Product product;
  String orderWeight;
  int orderQuantity;
  String orderSize;
  PdfImage pdfImage;
  String orderNote;
  String orderMarkings;
  OrderItem(
      {@required this.product,
      this.orderWeight,
      this.orderSize,
      @required this.orderQuantity,
      this.orderNote,
      this.orderMarkings}) {
    if (orderWeight == null) orderWeight = product.weight;
    if (orderSize == null) orderSize = product.size;
    if (orderNote == null) orderNote = 'No notes provided';
    if (orderMarkings == null) orderMarkings = 'No data provided';
    networkImageToByte(
            product.imgSrc)
        .then((value) {
      print('byteData generation complete ${product.itemCode}');

      pdfImage = PdfImage.file(pdf.document, bytes: value);
    });
  }
}

List<OrderItem> orderItems = [];
FinalOrder finalOrder;
Document pdf = Document();
List<Product> listOrderProductsGlobal = [];

initializeOrder(List<Product> orderProductsList) async {
  orderProductsList.forEach((element) {
    OrderItem orderItem = OrderItem(
        product: element,
        orderWeight: element.weight,
        orderSize: element.size,
        orderQuantity: 2);
    orderItems.add(orderItem);
  });

  finalOrder = FinalOrder(
      orderID: '#1074',
      partyName: 'Kalyan Jewellers',
      partyContact: '+91 8111 834 999',
      partyCity: 'Calicut',
      orderDate: DateTime.now(),
      orderDueDate: DateTime(2020, 11, 12),
      orderItems: orderItems);

  print(finalOrder.orderDueDate);
}
