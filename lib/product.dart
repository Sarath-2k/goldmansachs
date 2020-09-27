import 'package:flutter/foundation.dart';

class Product {
  String itemCode;
  String weight;
  String decsription;
  String size;
  // String type;
  // String name;
  String imgSrc;
  String category;

  Product(
      {@required this.itemCode,
      @required this.weight,
      this.decsription = "",
      this.size = "",
      // this.type = "",
      @required this.imgSrc,
      // @required this.name,
      @required this.category});
}

List<Product> products = [];
bool isLoading = false;
