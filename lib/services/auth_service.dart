import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../models/user.dart';

class AuthService {
  static const String USERS_KEY = 'users';
  static const String OTP_KEY = 'otps';
  static const int STARTING_NUMBER = 1000;
  
  Future<String> generateEmployeeId() async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(USERS_KEY) ?? [];
    final nextNumber = STARTING_NUMBER + users.length;
    return 'NLC$nextNumber';
  }

  Future<bool> sendOtp(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final otp = (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();
      
      final otpData = {
        'email': email,
        'otp': otp,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      
      final otps = prefs.getStringList(OTP_KEY) ?? [];
      otps.removeWhere((item) {
        final data = jsonDecode(item);
        return data['email'] == email;
      });
      otps.add(jsonEncode(otpData));
      await prefs.setStringList(OTP_KEY, otps);

      final smtpServer = gmail('imankush1010@gmail.com', '');
      final message = Message()
        ..from = Address('imankush1010@gmail.com', 'NALCO Registration')
        ..recipients.add(email)
        ..subject = 'NALCO Registration OTP'
        ..text = 'Your OTP for NALCO registration is: $otp\n\nThis OTP will expire in 10 minutes.';

      await send(message, smtpServer);
      return true;
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final otps = prefs.getStringList(OTP_KEY) ?? [];
      
      for (String otpStr in otps) {
        final otpData = jsonDecode(otpStr);
        if (otpData['email'] == email && otpData['otp'] == otp) {
          final timestamp = otpData['timestamp'] as int;
          final now = DateTime.now().millisecondsSinceEpoch;
          if (now - timestamp <= 600000) {
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }

  Future<User?> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(USERS_KEY) ?? [];
    
    for (String userStr in users) {
      final user = User.fromJson(jsonDecode(userStr));
      if (user.email == email) {
        return null;
      }
    }

    final employeeId = await generateEmployeeId();
    final newUser = User(
      email: email,
      password: password,
      employeeId: employeeId,
    );

    users.add(jsonEncode(newUser.toJson()));
    await prefs.setStringList(USERS_KEY, users);
    return newUser;
  }

  Future<User?> login(String employeeId, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(USERS_KEY) ?? [];

    for (String userStr in users) {
      final user = User.fromJson(jsonDecode(userStr));
      if (user.employeeId == employeeId && user.password == password) {
        return user;
      }
    }
    return null;
  }
}
