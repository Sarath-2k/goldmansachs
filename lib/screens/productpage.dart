import 'package:flutter/material.dart';
import 'package:goldmansachs/product.dart';

import '../order_model.dart';

class ProductPage extends StatelessWidget {
  ProductPage({this.product});
  final Product product;

  final GlobalKey<FormState> _orderFormKey = GlobalKey<FormState>();
  int orderQuantity;
  String orderSize;
  String orderWeight;
  String orderNotes;
  String orderSeal;

  addToOrderFormDialog(BuildContext context) {
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
                    Text('Category :  ${product.category}'),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Quantity :  '),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.24,
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
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Weight (g) :  '),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.24,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: product.weight,
                            onSaved: (value) {
                              orderWeight = value;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Size :  '),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                            initialValue: product.size,
                            onSaved: (value) {
                              orderSize = value;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Seal :  '),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                            initialValue: '',
                            onSaved: (value) {
                              orderSeal = value;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Notes :  '),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          // height: 30,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            initialValue: '',
                            maxLines: 3,
                            onSaved: (value) {
                              orderNotes = value;
                            },
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
                  }

                  _orderFormKey.currentState.save();

                  print(
                      '$orderQuantity , $orderSeal , $orderSize , $orderWeight , $orderNotes');
                },
                child: Text('ADD TO ORDER'),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.shop),
              onPressed: () {
                addToOrderFormDialog(context);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 460,
              width: 460,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  product.imgSrc,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 4, bottom: 12, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.itemCode,
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  Text('${product.weight} g',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            Column(children: [
              AddtnlInfoBar(
                  keyText: (product.size == null) ? '' : 'Size',
                  valueText: product.size),
            ]),
            Column(children: [
              AddtnlInfoBar(
                  keyText: (product.category == null) ? '' : 'Category',
                  valueText: product.category),
            ]),
            Column(children: [
              AddtnlInfoBar(
                  keyText: (product.category == null) ? '' : 'Description',
                  valueText: product.description),
            ]),
          ],
        ),
      ),
    );
  }
}

class AddtnlInfoBar extends StatelessWidget {
  final String keyText;
  final String valueText;
  AddtnlInfoBar({@required this.keyText, @required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (keyText != ''),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 128,
                child: Text(keyText, style: TextStyle(fontSize: 20))),
            Container(
              width: 260,
              child: Text(valueText,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
