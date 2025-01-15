import 'package:brothers_digi/Screens/Authentication/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _isChangingPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Change Password')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPasswordTextField('Old Password', _oldPasswordController),
            SizedBox(height: 16),
            _buildPasswordTextField('New Password', _newPasswordController),
            SizedBox(height: 16),
            _buildPasswordTextField('Confirm New Password', _confirmPasswordController),
            SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(ForgotPasswordScreen());
                  },
                  child: Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            SizedBox(height: 24),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: _isChangingPassword ? 0.5 : 1.0),
              duration: Duration(milliseconds: 300),
              builder: (context, double opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: ElevatedButton(
                    onPressed: _isChangingPassword ? null : _changePassword,
                    child: Text('Change Password'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Password text field with animation
  Widget _buildPasswordTextField(String label, TextEditingController controller) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 18)),
          TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Enter $label'),
          ),
        ],
      ),
    );
  }

  // Logic to change password
  Future<void> _changePassword() async {
    setState(() {
      _isChangingPassword = true;
    });

    try {
      User? user = _auth.currentUser;
      String oldPassword = _oldPasswordController.text;
      String newPassword = _newPasswordController.text;
      String confirmPassword = _confirmPasswordController.text;

      if (newPassword != confirmPassword) {
        showMessage('New passwords do not match');
        return;
      }

      // Re-authenticate user with old password before updating
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      showMessage('Password changed successfully!');
    } catch (e) {
      showMessage('Error: ${e.toString()}');
    } finally {
      setState(() {
        _isChangingPassword = false;
      });
    }
  }

  // Show message
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
