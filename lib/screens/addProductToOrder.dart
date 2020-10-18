import 'package:flutter/material.dart';
import 'package:goldmansachs/product.dart';
import 'package:goldmansachs/screens/homescreen.dart';

import '../order_model.dart';

final GlobalKey<FormState> _orderFormKey = GlobalKey<FormState>();

addToOrderFormDialog(BuildContext context, Product product) {
  int orderQuantity;
  String orderSize;
  String orderWeight;
  String orderNotes;
  String orderSeal;
  // listOrderProductsGlobal.add(product);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            'add to order',
            style: TextStyle(fontSize: 24),
          ),
          content: Form(
            key: _orderFormKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Item code :  ${product.itemCode}'),
                  SizedBox(height: 10),
                  Text('Category :    ${product.category}'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Quantity :  '),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.16,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: '1',
                          onSaved: (value) {
                            orderQuantity = int.parse(value);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Quantity is Required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              hintText: 'Quantity'),
                        ),
                      ),
                      SizedBox(width: 136)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Weight (g) :  '),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.16,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: product.weight,
                          onSaved: (value) {
                            orderWeight = value;
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              hintText: 'Weight'),
                        ),
                      ),
                      SizedBox(width: 150)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Size :  '),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          initialValue: product.size,
                          onSaved: (value) {
                            orderSize = value;
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              hintText: 'Size'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Seal :  '),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          initialValue: '',
                          onSaved: (value) {
                            orderSeal = value;
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              hintText: 'Seal'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Notes :  '),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        // height: 30,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          initialValue: '',
                          maxLines: 4,
                          onSaved: (value) {
                            orderNotes = value;
                          },
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              hintText: 'Notes go here'),
                        ),
                      )
                    ],
                  ),
                ]),
          ),
          actions: [
            RaisedButton(
              onPressed: () {
                if (!_orderFormKey.currentState.validate()) {
                  return;
                } else {
                  _orderFormKey.currentState.save();

                  print(
                      '$orderQuantity , $orderSeal , $orderSize , $orderWeight , $orderNotes');

                  OrderItem orderItem = OrderItem(
                      product: product,
                      orderWeight: orderWeight,
                      orderSize: orderSize,
                      orderQuantity: orderQuantity,
                      orderMarkings: orderSeal,
                      orderNote: orderNotes);
                  orderItems.add(orderItem);
                  
                  Navigator.pop(context);
                }
              },
              child: Text('ADD TO ORDER'),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.24),
          ],
        );
      });
}
