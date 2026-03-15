import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_catalog_app/model/product_model.dart';

class ApiService {
  Future<ProductModel> fetchProduct() async {
    final response = await http.get(
      Uri.parse("https://www.wantapi.com/products.php"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return ProductModel.fromJson(data);
    } else {
      throw Exception("Failed to load product!");
    }
  }
}
