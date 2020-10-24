import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:goldmansachs/product.dart';
import 'package:goldmansachs/screens/homescreen.dart';
import 'package:goldmansachs/screens/loginScreen.dart';
import 'package:image_picker/image_picker.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _code;
  String _category;
  String _imgSrc;
  String _weight;
  String _size;
  String _description;
  List<Image> image = [];

  File _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const categoryitems = <String>[
    "Chain",
    "Bangles",
    "Ear rings",
    "FInger rings",
    "Pendant"
  ];

  String selectedvalue;

  final Iterable<DropdownMenuItem<String>> _dropdownMenuItems = categoryitems
      .map(
        (String category) => DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        ),
      )
      .toList();

  Widget _buildCode() {
    return TextFormField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(), filled: true, hintText: 'Code'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Code is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _code = value;
      },
    );
  }

  Widget _buildWeight() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: UnderlineInputBorder(), filled: true, hintText: 'Weight'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Weight is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _weight = value;
      },
    );
  }

  Widget _buildSize() {
    return TextFormField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(), filled: true, hintText: 'Size'),
      // validator: (String value) {
      //   if (value.isEmpty) {
      //     return 'Size is Required';
      //   }

      //   return null;
      // },
      onSaved: (String value) {
        _size = value;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      maxLines: 7,
      decoration: InputDecoration(
        hintText: 'Description',
        border: UnderlineInputBorder(),
        filled: true,
      ),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      // validator: (String value) {
      //   return null;
      // },
      onSaved: (String value) {
        _description = value;
      },
    );
  }

  void openGallery() async {
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future _uploadimage() async {
    if (_image != null) {
      StorageReference ref = FirebaseStorage.instance.ref();
      StorageTaskSnapshot addImg =
          await ref.child("$uid/$_code").putFile(_image).onComplete;
      if (addImg.error == null) {
        print("added to Firebase Storage");
        _imgSrc = await addImg.ref.getDownloadURL();
        print(_imgSrc);
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
          title: Text("Add product"),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.view_array),
              onPressed: () => Navigator.pushReplacement(
                (context),
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              ),
            )
          ],
        ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //code&category
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildCode(),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 132,
                            child: ListTile(
                              trailing: DropdownButton(
                                  value: selectedvalue,
                                  hint: Text("Category"),
                                  items: _dropdownMenuItems,
                                  onChanged: ((String newValue) {
                                    setState(() {
                                      selectedvalue = newValue;
                                    });
                                  })),
                            ),
                          ),
                          // Expanded(
                          //   child: _buildCategory(),
                          //   flex: 2,
                          // ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),

                    //====================================================
                    //name
                    // Row(children: [
                    //   SizedBox(width: 10),
                    //   Expanded(
                    //     child: _buildName(),
                    //   ),
                    //   SizedBox(width: 10),
                    // ]),
                    // SizedBox(height: 20),
                    //====================================================
                    //weight&size
                    Container(
                      margin: EdgeInsets.only(top: 16, left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildWeight(),
                            flex: 2,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildSize(),
                            flex: 2,
                          ),
                        ],
                      ),
                    ),

                    //Description

                    Container(
                        margin: EdgeInsets.only(top: 16, left: 10, right: 10),
                        child: _buildDescription()),

                    Container(
                      height: 240,
                      width: 240,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(6),
                      margin: EdgeInsets.only(
                          top: 24, left: 10, right: 10, bottom: 36),
                      alignment: Alignment.bottomRight,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          _image != null
                              ? Container(
                                  height: 240,
                                  width: 240,
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black12,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.image),
                              onPressed: openGallery,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      highlightColor: Colors.green,
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        _formKey.currentState.save();

                        print(_code);
                        print(_category);
                        print(_weight);
                        print(_size);
                        print(_description);

                        _uploadimage().then((_) {
                          Product product = Product(
                              itemCode: _code,
                              weight: _weight,
                              imgSrc: _imgSrc,
                              category: _category);

                          FirebaseFirestore.instance
                              .collection(FirebaseAuth.instance.currentUser.uid)
                              .doc('products')
                              .collection('products')
                              .doc(_code)
                              .set({
                            'code': product.itemCode,
                            'category': product.category,
                            'weight': product.weight,
                            'size': product.size,
                            'description': product.description,
                            'imgSrc': product.imgSrc
                          });

                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Upload complete"),
                            duration: Duration(seconds: 2),
                          ));

                          setState(() {
                            _formKey.currentState.reset();
                            _image = null;
                          });
                        });

                        //Send to API
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
