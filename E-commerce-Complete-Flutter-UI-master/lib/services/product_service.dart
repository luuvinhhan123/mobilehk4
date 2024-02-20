import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';

class ProductService {
  // Phương thức để lấy danh sách sản phẩm từ API
  Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/product'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      // Chuyển đổi dữ liệu từ JSON thành danh sách các đối tượng Product
      List<Product> products = responseData.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Phương thức để lấy chi tiết của một sản phẩm từ API
  Future<Product> getProductDetails(int productId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/product/$productId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // Chuyển đổi dữ liệu từ JSON thành một đối tượng Product
      Product product = Product.fromJson(responseData);
      return product;
    } else {
      throw Exception('Failed to load product details');
    }
  }
}

// Định nghĩa lớp Product để biểu diễn dữ liệu sản phẩm
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  //final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    //required this.imageUrl,
  });

  // Phương thức tạo một đối tượng Product từ JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      //imageUrl: json['imageUrl'],
    );
  }
}
