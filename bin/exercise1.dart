//import 'package:exercise1/exercise1.dart' as exercise1;
import 'dart:io';

import 'package:exercise1/brand.dart';
import 'package:exercise1/product.dart';

void main(List<String> arguments) {
  //Read from file
  print("Enter your file name?");
  String fileName = stdin.readLineSync().toString();
  File file = File(fileName);

  //Intermediate process
  if (file.existsSync()) {
    String input = file.readAsStringSync();
    List<String> lines = input.split("\n");

    List<Product> products = [];
    Map productsIndexing = {};
    for (String line in lines) {
      List<String> data = line.split(",");
      if (productsIndexing.containsKey(data[2])) {
        Product myProduct = products[productsIndexing[data[2]]];
        myProduct.totalQuantity += int.parse(data[3]);
        if (myProduct.brandIndexing.containsKey(data[4].trim())) {
          int brandIndex = myProduct.brandIndexing[data[4].trim()]!;
          myProduct.brands[brandIndex].orders += 1;
          if (myProduct.brands[brandIndex].orders > myProduct.topBrand.orders) {
            myProduct.topBrand = myProduct.brands[brandIndex];
          }
        } else {
          myProduct.brands.add(Brand(data[4].trim(), 1));
          myProduct.brandIndexing[data[4].trim()] = myProduct.brands.length - 1;
        }
      } else {
        Product newProduct = Product(data[2], int.parse(data[3]));
        Brand newBrand = Brand(data[4].trim(), 1);
        newProduct.brands.add(newBrand);
        newProduct.topBrand = newProduct.brands[0];
        products.add(newProduct);
        productsIndexing[data[2]] = products.length - 1;
        products[0].brandIndexing[data[4].trim()] = 0;
      }
    }

    //Write in files
    File f1 = File("0_$fileName");
    File f2 = File("1_$fileName");

    for (int i = 0; i < products.length; i++) {
      double avgQuantity = products[i].totalQuantity / lines.length;
      f1.writeAsStringSync("${products[i].name},$avgQuantity\n",
          mode: FileMode.append);
      f2.writeAsStringSync("${products[i].name},${products[i].topBrand.name}\n",
          mode: FileMode.append);
    }
  } else {
    print("File not exist");
  }
}
