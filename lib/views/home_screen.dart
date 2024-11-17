import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            Text(
              'Employee ID: ${viewModel.currentUser?.employeeId}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}