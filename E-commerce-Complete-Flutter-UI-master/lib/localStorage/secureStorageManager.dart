import 'dart:async';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  static final SecureStorageManager _instance = SecureStorageManager._internal();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  factory SecureStorageManager() {
    return _instance;
  }

  SecureStorageManager._internal();

  Future<void> saveVerificationCode(String code) async {
    await _secureStorage.write(key: 'verification_code', value: code);
    await _secureStorage.write(key: 'verification_time', value: DateTime.now().millisecondsSinceEpoch.toString());
  }

  Future<String?> getVerificationCode() async {
    return await _secureStorage.read(key: 'verification_code');
  }

  Future<bool> isVerificationCodeValid() async {
    String? code = await getVerificationCode();
    if (code != null) {
      String? timeInMillisStr = await _secureStorage.read(key: 'verification_time');
      if (timeInMillisStr != null) {
        int timeInMillis = int.parse(timeInMillisStr);
        // Assume the verification code is valid for 30 seconds (adjust as needed)
        int validityDuration = 1 * 30 * 1000; // 30 seconds in milliseconds
        int currentTime = DateTime.now().millisecondsSinceEpoch;
        return (currentTime - timeInMillis) < validityDuration;
      }
    }
    return false;
  }

  Future<void> saveResetPasswordCode(String code) async {
    await _secureStorage.write(key: 'reset_password_code', value: code);
    await _secureStorage.write(key: 'reset_password_time', value: DateTime.now().millisecondsSinceEpoch.toString());
  }

  Future<String?> getResetPasswordCode() async {
    return await _secureStorage.read(key: 'reset_password_code');
  }

  Future<bool> isResetPasswordCodeValid() async {
    String? code = await getResetPasswordCode();
    if (code != null) {
      String? timeInMillisStr = await _secureStorage.read(key: 'reset_password_time');
      if (timeInMillisStr != null) {
        int timeInMillis = int.parse(timeInMillisStr);
        // Assume the reset password code is valid for 1 hour (adjust as needed)
        int validityDuration = 60 * 60 * 1000; // 1 hour in milliseconds
        int currentTime = DateTime.now().millisecondsSinceEpoch;
        return (currentTime - timeInMillis) < validityDuration;
      }
    }
    return false;
  }

  Future<void> clearVerificationCode() async {
    await _secureStorage.delete(key: 'verification_code');
    await _secureStorage.delete(key: 'verification_time');
  }

  Future<void> clearResetPasswordCode() async {
    await _secureStorage.delete(key: 'reset_password_code');
    await _secureStorage.delete(key: 'reset_password_time');
  }
}

String generateVerificationCode() {
  Random random = Random();
  return (1000 + random.nextInt(9000)).toString(); // 4-digit verification code
}

String generateResetPasswordCode() {
  const int resetCodeLength = 8;
  const String characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(List.generate(resetCodeLength, (index) => characters.codeUnitAt(random.nextInt(characters.length))));
}
