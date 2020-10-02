import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
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
                  'https://lh3.googleusercontent.com/proxy/S_BtJ9Bk8cpVPchMMNHdFRcfYkpXVYlf3XUgAcMkUTQIy3d7na18cu5hA22mj3Cn7XeZ3HYCyfF_CEim23ukEBa33ucXRbt95Rw_61-oZtxsBKHnCnFIoaHbhpRBrMBOGMeFAjDr8UpNzD4evcblaTDkOiQ7qa1Q6XBqvtgebGt12L6Cq1DQal4bfw',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left:20, top: 4, bottom: 12, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('FR1012',
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  Text('24.8g',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            Column(children: [
              AddtnlInfoBar(
                  keyText: ('Size' == null) ? '' : 'Size', valueText: 'Medium'),
            ]),
            Column(children: [
              AddtnlInfoBar(
                  keyText: ('Category' == null) ? '' : 'Category', valueText: 'Finger ring'),
            ]),
            Column(children: [
              AddtnlInfoBar(
                  keyText: ('Description' == null) ? '' : 'Description', valueText: 'New model\nSingapore Collection\nLimited quantity'),
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
          borderRadius: BorderRadius.circular(20),
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
