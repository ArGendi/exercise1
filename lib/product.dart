import 'package:exercise1/brand.dart';

class Product {
  late String name;
  late int totalQuantity;
  late List<Brand> brands;
  late Map<String, int> brandIndexing;
  late Brand topBrand;

  Product(this.name, this.totalQuantity) {
    brands = [];
    brandIndexing = {};
  }
}
