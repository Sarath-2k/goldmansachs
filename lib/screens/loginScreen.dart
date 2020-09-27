import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goldmansachs/main.dart';
import 'package:goldmansachs/screens/homescreen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

String uid;

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String username;
  String password;

  User user;

  @override
  void initState() {
    initializeFirebaseApp();
    print('should have been initialized by now');
    super.initState();
  }

  _login() async {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "test@test.com", password: "testaf")
          .then((_) {
        user = FirebaseAuth.instance.currentUser;
        // print("\n\n $user \n\n");
        if (user != null) {
          uid = user.uid;
          print("user: ${user.email}");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'BB GOLD',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 3),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
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
                onTap: _login,
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

            // Container(
            //   height: 50,
            //   margin: EdgeInsets.symmetric(horizontal: 150),
            //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            //   child: RaisedButton(
            //       textColor: Colors.white,
            //       color: Colors.blue,
            //       child: Text('Login'),
            //       onPressed: _login),
            // )
          ],
        ),
      ),
    );
  }
}
