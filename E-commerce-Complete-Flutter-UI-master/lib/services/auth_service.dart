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

  // Hàm mới để gửi email và password lên server
  Future<Map<String, dynamic>> sendEmailAndPassword(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/'),
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
      // Kiểm tra xem phản hồi có chứa token hay không
      if (responseData.containsKey('token')) {
        final token = responseData['token'];
        await _saveTokenLocally(token); // Lưu token vào bộ nhớ cục bộ
      } else {
        throw Exception('Token not found in response');
      }
      return responseData;
    } else {
      throw Exception('Failed to send email and password');
    }
  }

  // Hàm login sẽ gọi hàm sendEmailAndPassword và xử lý "remember me"
  Future<Map<String, dynamic>> login(
      String email, String password, bool rememberMe) async {
    final responseData = await sendEmailAndPassword(email, password);

    if (rememberMe) {
      // Lưu email và password vào storage nếu rememberMe được chọn
      await saveRememberedCredentials(email, password);
    }

    return responseData;
  }

  Future<bool> getRememberMe() async {
    final rememberMe = await storage.read(key: 'remember_me');
    return rememberMe == 'true';
  }

  Future<void> saveRememberMe(bool rememberMe) async {
    await storage.write(key: 'remember_me', value: rememberMe.toString());
  }

  // Hàm lưu email và password
  Future<void> saveRememberedCredentials(String email, String password) async {
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
  }

  // Hàm lấy email và password đã lưu
  Future<Map<String, String>> getRememberedCredentials() async {
    final email = await storage.read(key: 'email');
    final password = await storage.read(key: 'password');
    return {'email': email ?? '', 'password': password ?? ''};
  }

  // Hàm kiểm tra trạng thái đăng nhập
  Future<bool> isLoggedIn() async {
    final token = await getStoredToken();
    return token != null;
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
    print('Token saved: $token');
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

  // Future<void> resetPassword(String email, String newPassword) async {
  //   try {
  //     final resetCode = await secureStorageManager
  //         .getResetPasswordCode(); // Get reset code from local storage
  //     // Validate reset code here

  //     // If reset code is valid, set new password
  //     await authService.updatePassword(email, newPassword);

  //     // Clear reset code after resetting password
  //     await secureStorageManager.clearResetPasswordCode();
  //   } catch (e) {
  //     print('Error resetting password: $e');
  //     rethrow;
  //   }
  // }
  
}
