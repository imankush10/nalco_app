// predict_screen.dart
import 'package:flutter/material.dart';
import 'results_screen.dart';

class PredictScreen extends StatefulWidget {
  @override
  _PredictScreenState createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  int _selectedIndex = 1; // Set to 1 for Predict screen

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    
    if (index == 0) {
      Navigator.pop(context); // Go back to home
      return;
    }
    // Add navigation for other indices when you create those screens
    setState(() {
      _selectedIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xFFB71C1C),
        title: Text('Predict Parameters'),
        elevation: 0,
      ),
      body: Column(
        children: [
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
                  _buildInputField('Casting Temperature (°C)'),
                  _buildInputField('Cooling Water Temperature (°C)'),
                  _buildInputField('Casting Speed (m/min)'),
                  _buildInputField('Cast Bar Entry Temperature (°C)'),
                  _buildInputField('Emulsion Temperature (°C)'),
                  _buildInputField('Emulsion Pressure (bar)'),
                  _buildInputField('Emulsion Concentration (%)'),
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
    );
  }

  Widget _buildInputField(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Center(
        child: SizedBox(
          width: 375,
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
        ),
      ),
    );
  }
}