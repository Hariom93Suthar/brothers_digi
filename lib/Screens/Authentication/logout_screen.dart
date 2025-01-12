import 'package:brothers_digi/Screens/Authentication/registration_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthHelper {
  static final AuthHelper _instance = AuthHelper._internal();
  factory AuthHelper() => _instance;
  AuthHelper._internal();

  /// Function to handle logout with confirmation dialog
  Future<void> logoutWithSnackbar(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut(); // Firebase logout

                  // Use Future.delayed to ensure context is valid after navigation
                  Future.delayed(Duration(seconds: 1), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout successful!'),
                        backgroundColor: Colors.green,
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  });

                  Get.to(() => RegistrationScreen()); // Navigate to Registration Screen
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error during logout: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
