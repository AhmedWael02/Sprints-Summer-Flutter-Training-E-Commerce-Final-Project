import 'dart:convert';
import 'package:ahmed_wael_ecommerce_app/model/model.dart';
import 'package:http/http.dart' as http;

class Service {
  final String apiUrl = "https://dummyjson.com/products";

  Future<List<Model>> fetchProducts() async {
    // Fetch products from the API
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);

      if (responseData.containsKey("products")) {
        final List<dynamic> jsonData = responseData["products"];

        return jsonData
            .map((productJson) => Model.fromJson(productJson))
            .toList();
      } else {
        throw Exception("API response does not contain a 'products' key");
      }
    } else {
      throw Exception("Failed to load products");
    }
  }
}
