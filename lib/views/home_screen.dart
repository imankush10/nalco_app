import 'package:flutter/material.dart';
import 'results_screen.dart';

class HomeScreen extends StatelessWidget {
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
            // Input Fields
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Parameters',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB71C1C),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildInputField('Chemical Composition (%)'),
                    _buildInputField('Casting Temperature (°C)'),
                    _buildInputField('Cooling Water Temperature (°C)'),
                    _buildInputField('Casting Speed (m/min)'),
                    _buildInputField('Cast Bar Entry Temperature (°C)'),
                    _buildInputField('Emulsion Temperature (°C)'),
                    _buildInputField('Emulsion Pressure (bar)'),
                    _buildInputField('Emulsion Concentration (%)'),
                    _buildInputField('Rod Quench Water Pressure (bar)'),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultsScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB71C1C),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Predict',
                          style: TextStyle(fontSize: 18),
                        ),
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
      ),
    );
  }

  Widget _buildInputField(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: TextInputType.number,
      ),
    );
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