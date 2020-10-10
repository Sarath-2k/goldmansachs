import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goldmansachs/screens/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      theme: ThemeData(primaryColor: Colors.green),
      home: LoginPage(),
    );
  }
}

void initializeFirebaseApp() {
  Firebase.initializeApp().then((_) {
    print('Flirebase initialized Succesfully...!');
  });
}