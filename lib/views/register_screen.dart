import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Consumer<AuthViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
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
                          final success = await viewModel.register(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Registration successful! Your Employee ID is: ${viewModel.currentUser?.employeeId}',
                                ),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                        },
                  child: viewModel.isLoading
                      ? CircularProgressIndicator()
                      : Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Already have an account? Login'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
