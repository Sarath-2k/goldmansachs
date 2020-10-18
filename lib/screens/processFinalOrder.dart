import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../order_model.dart';
import 'report_pdf.dart';

processOrderForm(BuildContext context) {
  final GlobalKey<FormState> _orderProcessFormKey = GlobalKey<FormState>();

  String orderID;
  DateTime orderDate = DateTime.now();
  DateTime orderDueDate = DateTime.now().add(Duration(days: 20));

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
                        width: MediaQuery.of(context).size.width * 0.32,
                        child: TextFormField(
                          initialValue: '#',
                          onSaved: (value) {
                            orderID = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty || value == '#') {
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
                      SizedBox(width: 15)
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                      'Order Date :             ${intl.DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Order Due Date :     ${intl.DateFormat('dd/MM/yyyy').format(orderDueDate)}'),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30,
                        // width: MediaQuery.of(context).size.width * 0.30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // orderDueDate ?? Text('Select a date'),
                            IconButton(
                              icon: Icon(Icons.date_range, color: Colors.green),
                              onPressed: () async {
                                orderDueDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 120)),
                                );
                                
                              },
                            )
                          ],
                        ),

                        // TextFormField(
                        //   // initialValue: product.size,
                        //   onSaved: (value) {
                        //     orderDueDate = DateTime.now();
                        //   },
                        //   decoration: InputDecoration(
                        //       border: UnderlineInputBorder(),
                        //       filled: true,
                        //       hintText: 'Due Date'),
                        // ),
                      ),
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
