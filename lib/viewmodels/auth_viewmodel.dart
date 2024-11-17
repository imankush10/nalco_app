import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? error;
  User? currentUser;

  Future<bool> register(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
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