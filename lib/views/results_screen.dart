import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xFFB71C1C),
        title: Text('Prediction Results'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Predicted Properties:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
            SizedBox(height: 20),
            _buildResultCard(
              'Ultimate Tensile Strength (UTS)',
              '450 MPa',
              Icons.speed,
            ),
            _buildResultCard(
              'Elongation',
              '25%',
              Icons.straighten,
            ),
            _buildResultCard(
              'Conductivity',
              '58% IACS',
              Icons.electric_bolt,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(String label, String value, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: Color(0xFFB71C1C),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB71C1C),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}