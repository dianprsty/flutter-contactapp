import 'dart:developer';

import 'package:contactapp/core/helper/api_helper.dart';
import 'package:contactapp/product/model/product_model.dart';

final apiHelper = ApiHelper(
  baseUrl: "https://busy-erin-coyote-toga.cyclic.app",
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
);

Future<List<Product>?> getAllProducts() async {
  List<Product> products = [];

  try {
    final response = await apiHelper.dio.get("/api/products");

    dynamic data = response.data;
    if (response.statusCode == 200) {
      for (var product in data["data"]) {
        products.add(Product.fromMap(product));
      }

      return products;
    } else {
      throw Exception("Failed to get data");
    }
  } catch (e) {
    log("Get All Products Error : $e");
  }

  return [];
}
