import 'package:flutter/material.dart';
import 'package:goldmansachs/product.dart';

class ProductPage extends StatelessWidget {
  ProductPage({this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
