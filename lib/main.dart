import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goldmansachs/screens/homescreen.dart';
import 'package:goldmansachs/screens/loginScreen.dart';
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
      home: LoginPage(),
    );
  }
}

initializeFirebaseApp() {
  Firebase.initializeApp()
      .then((_) => print('Flirebase initialized Succesfully...!'));
}
