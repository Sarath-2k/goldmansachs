import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../order_model.dart';
import 'report_pdf.dart';

processOrderForm(BuildContext context) {
  final GlobalKey<FormState> _orderProcessFormKey = GlobalKey<FormState>();

  String orderID;
  DateTime orderDate = DateTime.now();
  DateTime orderDueDate;

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            'process order',
            style: TextStyle(fontSize: 24),
          ),
          content: Form(
            key: _orderProcessFormKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Order ID :  '),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.24,
                        child: TextFormField(
                          initialValue: '#',
                          onSaved: (value) {
                            orderID = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Order ID is Required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              hintText: 'orderID'),
                        ),
                      ),
                      SizedBox(width: 140)
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                      'Order Date :  ${intl.DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Order Due Date :  '),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          // initialValue: product.size,
                          onSaved: (value) {
                            orderDueDate = DateTime.now();
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              hintText: 'Due Date'),
                        ),
                      )
                    ],
                  ),
                ]),
          ),
          actions: [
            RaisedButton(
              onPressed: () {
                if (!_orderProcessFormKey.currentState.validate()) {
                  return;
                }

                _orderProcessFormKey.currentState.save();
                initializeOrder(
                    orderID: orderID,
                    orderDate: orderDate,
                    orderDueDate: orderDueDate);
                Navigator.pop(context);

                reportView(context);
                orderItems = [];
              },
              child: Text('PROCESS ORDER'),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.22),
          ],
        );
      });
}
