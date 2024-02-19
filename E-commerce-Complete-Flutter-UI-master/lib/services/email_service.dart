import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  static final EmailService _instance = EmailService._internal();

  factory EmailService() {
    return _instance;
  }

  EmailService._internal();

  Future<bool> sendVerificationEmail(String email, String verificationCode) async {
    String username = 'fashionforwardeshop@yahoo.com'; // Thay đổi thành địa chỉ email của bạn
    String password = 'Projecthk4@'; // Thay đổi thành mật khẩu email của bạn

    final smtpServer = yahoo(username, password);

    final message = Message()
      ..from = Address(username, 'Fashion Forward')
      ..recipients.add(email)
      ..subject = 'Email Verification'
      ..text = 'Your verification code is: $verificationCode';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> sendResetPasswordEmail(String email, String resetCode) async {
    String username = 'fashionforwardeshop@yahoo.com'; // Thay đổi thành địa chỉ email của bạn
    String password = 'Projecthk4@'; // Thay đổi thành mật khẩu email của bạn

    final smtpServer = yahoo(username, password);

    final message = Message()
      ..from = Address(username, 'Your App Name')
      ..recipients.add(email)
      ..subject = 'Reset Password'
      ..text = 'Your reset password code is: $resetCode';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
