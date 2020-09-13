import 'package:flutter/foundation.dart';

class Product {
  String itemCode;
  double weight;
  String decsription;
  String size;
  String type;
  String name;
  String imgSrc;
  ProductCategory category;

  Product(
      {@required this.itemCode,
      @required this.weight,
      this.decsription = "",
      this.size = "",
      this.type = "",
      this.imgSrc = "",
      @required this.name,
      @required this.category});
}

enum ProductCategory { chain, necklace, earring, fingerring, pendant, bangles }
