import 'package:firebase_auth/firebase_auth.dart';
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
  _login() async {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "test@test.com", password: "testaf")
          .then((_) {
        user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          uid = user.uid;
          print("user: ${user.email}");
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Firebase.initializeApp().then((_) {
    print('Flirebase initialized Succesfully...!');
    _login();
  });
}
