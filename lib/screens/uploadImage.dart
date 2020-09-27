import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UploadImgScreen extends StatefulWidget {
  @override
  _UploadImgScreenState createState() => _UploadImgScreenState();
}

class _UploadImgScreenState extends State<UploadImgScreen> {
  File _image;
  @override
  void initState() {
    super.initState();
  }

  void openCamera() async {
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void openGallery() async {
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _uploadimage() async {
    if (_image != null) {
      StorageReference ref = FirebaseStorage.instance.ref();
      StorageTaskSnapshot addImg =
          await ref.child("image/img").putFile(_image).onComplete;
      if (addImg.error == null) {
        print("added to Firebase Storage");
        final String downloadUrl = await addImg.ref.getDownloadURL();
        print(downloadUrl);

        await FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser.uid)
            .doc('products')
            .collection('images')
            .add({"url": downloadUrl, "name": 'iphone'});
      } else {
        print('Error from image repo ${addImg.error.toString()}');
        throw ('This file is not an image');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload image to firebase"),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.grey[200],
                  height: 300.0,
                  width: 900.0,
                  child: _image == null
                      ? Center(child: Text("Still waiting!"))
                      : Image.file(_image),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      color: Colors.deepOrangeAccent,
                      child: Text(
                        "Open Camera",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        openCamera();
                      },
                    ),
                    RaisedButton(
                      child: Text("Save Image"),
                      onPressed: _uploadimage,
                    ),
                    FlatButton(
                      color: Colors.limeAccent,
                      child: Text(
                        "Open Gallery",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        openGallery();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
