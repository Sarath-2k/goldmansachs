import 'package:flutter/foundation.dart';

class Product {
  String itemCode;
  String weight;
  String description;
  String size;
  // String type;
  // String name;
  String imgSrc;
  String category;

  Product(
      {@required this.itemCode,
      @required this.weight,
      this.description = "",
      this.size = "",
      // this.type = "",
      @required this.imgSrc,
      // @required this.name,
      @required this.category});
}

List<Product> products = [];
bool isLoading = false;

List<String> listCategory = [
  "Chain",
  "Bangles",
  "Ear rings",
  "FInger rings",
  "Pendant",
  "Neckalce",
];
