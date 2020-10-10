import 'package:flutter/foundation.dart';

class Product {
  String itemCode;
  String weight;
  String description;
  String size;

  String imgSrc;
  String category;

  Product(
      {@required this.itemCode,
      @required this.weight,
      this.description = "",
      this.size = "",
      @required this.imgSrc,
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
