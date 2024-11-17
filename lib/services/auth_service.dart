import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static const String USERS_KEY = 'users';
  static const int STARTING_NUMBER = 1000;  // Starting number for first user
  
  Future<String> generateEmployeeId() async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(USERS_KEY) ?? [];
    
    // Next number will be STARTING_NUMBER + number of existing users
    final nextNumber = STARTING_NUMBER + users.length;
    
    // Format to ensure 4 digits
    return 'NLC$nextNumber';
  }

  Future<User?> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(USERS_KEY) ?? [];
    
    // Check if email already exists
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