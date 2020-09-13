import 'package:flutter/material.dart';
import 'package:goldmansachs/screens/homescreen.dart';
import 'package:goldmansachs/screens/uploadImage.dart';
import 'package:goldmansachs/screens/uploadProduct.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadProductData(),
    );
  }
}
