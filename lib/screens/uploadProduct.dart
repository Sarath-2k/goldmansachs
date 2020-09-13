import 'package:flutter/material.dart';
import 'package:goldmansachs/product.dart';

class UploadProductData extends StatefulWidget {
  @override
  _UploadProductDataState createState() => _UploadProductDataState();
}

class _UploadProductDataState extends State<UploadProductData> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int category;
    int _value = 1;
    return Scaffold(
        appBar: AppBar(
          title: Text("GoldmanSachs"),
        ),
        body: Column(children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: DropdownButton(
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text("First Item"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Second Item"),
                        value: 2,
                      ),
                      DropdownMenuItem(child: Text("Third Item"), value: 3),
                      DropdownMenuItem(child: Text("Fourth Item"), value: 4)
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    }),
              ),
              // Container(
              //   padding: EdgeInsets.all(8),
              //   width: size.width / 2,
              //   child: DropdownButton(
              //       value: category,
              //       hint: Text("Select Category"),
              //       items: [
              //         DropdownMenuItem(
              //           child: Text("Chain"),
              //           value: 0,
              //         ),
              //         DropdownMenuItem(
              //           child: Text("Necklace"),
              //           value: 1,
              //         ),
              //         DropdownMenuItem(
              //           child: Text("Bangles"),
              //           value: 2,
              //         ),
              //         DropdownMenuItem(
              //           child: Text("Finger Ring"),
              //           value: 3,
              //         ),
              //         DropdownMenuItem(
              //           child: Text("Ear Ring"),
              //           value: 4,
              //         ),
              //         DropdownMenuItem(
              //           child: Text("Pendant"),
              //           value: 5,
              //         ),
              //       ],
              //       onChanged: (value) {
              //         setState(() {
              //           category = value;
              //           print("Category: $value");
              //         });
              //       }),
              // ),
              Container(width: size.width / 2, child: MyTextFormField()),
            ],
          ),
        ]));
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: "Item code",
              // hintText: "Search",
              prefixIcon: Icon(Icons.qr_code),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          validator: validator,
          onSaved: onSaved,
        ),
      ),
    );
  }
}
