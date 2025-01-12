import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Enter your email to reset your password', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Enter your email address'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Send Reset Link'),
            ),
          ],
        ),
      ),
    );
  }

  // Logic to send reset password link
  Future<void> _resetPassword() async {
    try {
      String email = _emailController.text;

      await _auth.sendPasswordResetEmail(email: email);

      showMessage('Password reset link has been sent to your email');
    } catch (e) {
      showMessage('Error: ${e.toString()}');
    }
  }

  // Show message
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
