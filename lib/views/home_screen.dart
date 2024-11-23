import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'predict_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  int _selectedIndex = 0;
  bool _isNavigating = false;  // Add this flag to track actual navigation

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final employeeId = prefs.getString('employeeId') ?? '';
    final users = prefs.getStringList('users') ?? [];
    
    for (String userStr in users) {
      final user = jsonDecode(userStr);
      if (user['employeeId'] == employeeId) {
        setState(() {
          username = user['email'].split('@')[0];
        });
        break;
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add a small delay to show the highlight before navigation
    if (index == 1) {
      _isNavigating = true;
      Future.delayed(Duration(milliseconds: 150), () {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PredictScreen()),
        ).then((_) {
          if (!mounted) return;
          setState(() {
            _selectedIndex = 0;
            _isNavigating = false;
          });
        });
      });
    }
    // For Control and Tinker, we'll just show the highlight
    // Later you can add navigation logic similar to Predict
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 6),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.mic, color: Colors.black),
                  Container(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'lib/assets/nalco-logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFB71C1C)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Eng',
                      style: TextStyle(
                        color: Color(0xFFB71C1C),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Welcome Message
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB71C1C),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Navigation Bar
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFB71C1C),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem('Home', Icons.home, _selectedIndex == 0),
                    _buildNavItem('Predict', Icons.analytics, _selectedIndex == 1),
                    _buildNavItem('Control', Icons.settings, _selectedIndex == 2),
                    _buildNavItem('Tinker', Icons.build, _selectedIndex == 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () => _onItemTapped(['Home', 'Predict', 'Control', 'Tinker'].indexOf(label)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white70,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}