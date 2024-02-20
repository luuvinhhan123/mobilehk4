import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';

class UserService {
  static const String bUrl = 'http://$baseUrl/api/users';

  Future<List<dynamic>> getAllUsers() async {
    final response = await http.get(Uri.parse(bUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<dynamic> getUserById(int userId) async {
    final response = await http.get(Uri.parse('$bUrl/$userId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<dynamic> updateUser(int userId, dynamic updatedUser) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedUser),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> updatePassword(int userId, String newPassword) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$userId/update-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newPassword': newPassword,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update password');
    }
  }
}
