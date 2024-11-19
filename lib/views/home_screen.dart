import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 6),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              Expanded(
                child: Center(
                  child: Text('Welcome!'),
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
                      _buildNavItem('Home', Icons.home, true),
                      _buildNavItem('Predict', Icons.analytics, false),
                      _buildNavItem('Control', Icons.settings, false),
                      _buildNavItem('Tinker', Icons.build, false),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildNavItem(String label, IconData icon, bool isSelected) {
    return Column(
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
    );
  }
}
