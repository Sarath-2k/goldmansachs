import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goldmansachs/main.dart';
import 'package:goldmansachs/screens/homescreen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

String uid;
User user;
String accessCode;

class _State extends State<LoginPage> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  String username;
  String password;

  @override
  void initState() {
    initializeFirebaseApp();
    print('should have been initialized by now');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   title: Center(
      //       child: Text(
      //     'Login',
      //     style: TextStyle(color: Colors.black),
      //   )),
      // ),
      body: Form(
        key: _loginFormKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'goldmansachs',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        letterSpacing: 3),
                  )),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.75,
              //   padding: EdgeInsets.all(10),
              //   child: TextField(
              //     controller: nameController,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'User Name',
              //     ),
              //   ),
              // ),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.75,
              //   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              //   child: TextField(
              //     obscureText: true,
              //     controller: passwordController,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Password',
              //     ),
              //   ),
              // ),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: codeController,
                  obscureText: true,
                  validator: (String value) {
                    if (value != 'admin' && value != 'admin') {
                      return 'Invalid access code';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Access Code',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.green,
                ),
                child: InkWell(
                  splashColor: Colors.green,
                  onTap: () {
                    if (!_loginFormKey.currentState.validate()) {
                      return;
                    } else {
                      accessCode = codeController.text;
                      print('accessCode: $accessCode');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  },
                  child: Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
