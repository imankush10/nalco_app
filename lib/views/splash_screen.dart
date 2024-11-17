import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'login_screen.dart';
import 'register_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to appropriate screen after 3 seconds
    Timer(Duration(seconds: 3), () => _checkFirstTime());
  }

  void _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final hasUsers = prefs.getStringList('users')?.isNotEmpty ?? false;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => hasUsers ? LoginScreen() : RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // You can add your logo here
            Icon(
              Icons.business,  // Replace with your app icon
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 24),
            Text(
              'NLC Employee App',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}