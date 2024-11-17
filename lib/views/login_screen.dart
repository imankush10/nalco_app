import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _employeeIdController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _employeeIdController,
                  decoration: InputDecoration(labelText: 'Employee ID'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 24),
                if (viewModel.error != null)
                  Text(
                    viewModel.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: viewModel.isLoading
                      ? null
                      : () async {
                          final success = await viewModel.login(
                            _employeeIdController.text,
                            _passwordController.text,
                          );
                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          }
                        },
                  child: viewModel.isLoading
                      ? CircularProgressIndicator()
                      : Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text('Don\'t have an account? Register'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}