import 'package:flutter/material.dart';
import 'package:goldmansachs/screens/uploadImage.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _code;
  String _category;
  String _name;
  String _weight;
  String _size;
  String _description;
  List<Image> image = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const categoryitems = <String>["Blah1", "Blah2", "Blah3", "Blah4"];

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

  // Widget _buildCategory() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         border: UnderlineInputBorder(), filled: true, hintText: 'Category'),
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Category is Required';
  //       }
  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _category = value;
  //     },
  //   );
  // }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(), filled: true, hintText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildWeight() {
    return TextFormField(
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Size is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _size = value;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Description',
        border: UnderlineInputBorder(),
        filled: true,
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        return null;
      },
      onSaved: (String value) {
        _description = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              //code&category
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildCode(),
                    flex: 2,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
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
              SizedBox(height: 20),
              //name
              Row(children: [
                SizedBox(width: 10),
                Expanded(
                  child: _buildName(),
                ),
                SizedBox(width: 10),
              ]),
              SizedBox(height: 20),
              //weight&size
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildWeight(),
                    flex: 2,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildSize(),
                    flex: 2,
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 20),
              //Description
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(child: _buildDescription()),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 50),
              Container(
                  child: IconButton(
                      icon: Icon(Icons.add_a_photo), onPressed: () {})),
              SizedBox(height: 50),
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  print(_code);
                  print(_category);
                  print(_name);
                  print(_weight);
                  print(_size);
                  print(_description);

                  //Send to API
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
