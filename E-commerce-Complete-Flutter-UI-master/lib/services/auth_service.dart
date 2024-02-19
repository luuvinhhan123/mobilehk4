import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/localStorage/secureStorageManager.dart';
import 'package:shop_app/services/email_service.dart';

class AuthService {
  final storage = const FlutterSecureStorage();
  final emailService = EmailService();
  final secureStorageManager = SecureStorageManager();

  Future<Map<String, dynamic>> login(
      String email, String password, bool rememberMe) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (rememberMe) {
        await _saveTokenLocally(responseData['jwt']);
      }
      return responseData;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final resetCode = generateResetPasswordCode(); // Generate reset code
      await emailService.sendResetPasswordEmail(
          email, resetCode); // Send reset password email
      await secureStorageManager
          .saveResetPasswordCode(resetCode); // Save reset code locally
    } catch (e) {
      print('Error during password reset: $e');
      rethrow;
    }
  }

  Future<void> _saveTokenLocally(String token) async {
    await storage.write(key: 'jwt', value: token);
  }

  Future<String?> getStoredToken() async {
    return await storage.read(key: 'jwt');
  }

  Future<void> removeStoredToken() async {
    try {
      await storage.delete(key: 'jwt');
    } catch (e) {
      print('Error during removing token: $e');
      rethrow;
    }

    // Hàm kiểm tra trạng thái đăng nhập
    Future<bool> isLoggedIn() async {
      final token = await getStoredToken();
      return token != null;
    }

// Hàm logout sẽ xóa token đã lưu trữ
    Future<void> logout() async {
      try {
        await removeStoredToken();
      } catch (e) {
        print('Error during logout: $e');
        rethrow;
      }
    }
  }
}
