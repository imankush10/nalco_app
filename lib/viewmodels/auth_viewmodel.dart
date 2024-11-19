import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? error;
  User? currentUser;

  Future<bool> sendOtpForRegistration(String email) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final success = await _authService.sendOtp(email);
      isLoading = false;
      if (!success) {
        error = 'Failed to send OTP';
      }
      notifyListeners();
      return success;
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> resendOtp(String email) async {
    error = null;
    notifyListeners();
    return await _authService.sendOtp(email);
  }

  Future<bool> verifyOtpAndRegister(String email, String password, String otp) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final isOtpValid = await _authService.verifyOtp(email, otp);
      if (!isOtpValid) {
        isLoading = false;
        error = 'Invalid OTP';
        notifyListeners();
        return false;
      }

      final user = await _authService.register(email, password);
      isLoading = false;
      if (user != null) {
        currentUser = user;
        notifyListeners();
        return true;
      }
      error = 'Email already exists';
      notifyListeners();
      return false;
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String employeeId, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final user = await _authService.login(employeeId, password);
      isLoading = false;
      if (user != null) {
        currentUser = user;
        notifyListeners();
        return true;
      }
      error = 'Invalid credentials';
      notifyListeners();
      return false;
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }
}