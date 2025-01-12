import 'package:brothers_digi/Screens/Authentication/login_user.dart';
import 'package:brothers_digi/Screens/Authentication/success_screen.dart';
import 'package:brothers_digi/Screens/bottemNav/home_screen.dart';
import 'package:brothers_digi/Widgets/form_field.dart';
import 'package:brothers_digi/Widgets/helper_function.dart';
import 'package:brothers_digi/services/auth_service.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullname = "";
  String mobile = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _nameController = TextEditingController();
  var _mobileController = TextEditingController();


  Future<void> _registerUser() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String mobile = _mobileController.text;

    try {
      // Register the user and store data in Firebase
      await _firestore.collection('users').doc(email).set({
        'fullName':name,
        'email': email,
        'mobile':mobile,
        'password': password,  // In practice, hash the password before storing it
        'isAdmin': false,  // Set isAdmin to false by default
      });

      print("User registered with email: $email");

      // Proceed with further actions like navigating to login page, etc.
      // Example: Navigator.pushNamed(context, '/login');

    } catch (e) {
      print("Error registering user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      )
          : Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFF0318ae),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/uilogo.png",
                color: Colors.white,
                height: height*.40,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: height*.32),
                child: Text(
                  "नमस्कार !",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height*.60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, left: 40, right: 40),
                  child: Form(
                    key: formKey, // Assign formKey to Form widget
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                          ),
                          onChanged: (val) {
                            setState(() {
                              fullname = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name can't be empty";
                            }
                          },
                        ),
                        SizedBox(height:height*.03),
                        TextFormField(
                          controller: _mobileController,
                          decoration: textInputDecoration.copyWith(
                            labelText: "Mobile",
                            prefixIcon: Icon(Icons.phone),
                          ),
                          onChanged: (val) {
                            setState(() {
                              mobile = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Mobile can't be empty";
                            }
                          },
                        ),
                        SizedBox(height:height*.03),
                        TextFormField(
                          controller: _emailController,
                          decoration: textInputDecoration.copyWith(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (val) {
                            return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                        ),
                        SizedBox(height:height*.03),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (val) {
                            if (val!.length < 8) {
                              return "Password must be at least 8 characters";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(height: height*.05),
                        InkWell(
                          onTap: () {
                            register();
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                "REGISTER",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CustomColor.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: height*.02),
                        Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 19,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  nextscreen(Login());},
                                text: "Login here",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.deepPurple,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Your register function
  register() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Check if AuthService is initialized
        if (authService == null) {
          throw Exception("AuthService is not initialized");
        }

        // Call registerUserWithEmailAndPassword from AuthService
        var result = await authService.registerUserWithEmailAndPassword(
            fullname, mobile, email, password);

        // Handle the result
        if (result == true) {
          // Save user session details
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullname);

          // Navigate to SuccessScreen
          print("Successfully registered");
          Get.to(SuccessScreen());
        } else {
          // Handle specific registration errors
          Get.snackbar(
            "Registration Failed",
            result.toString(),
            colorText: Colors.red,
          );
        }
      } on FirebaseAuthException catch (e) {
        // Firebase-specific errors
        print("FirebaseAuthException: ${e.message}");
        Get.snackbar(
          "Firebase Error",
          e.message ?? "An error occurred during registration.",
          colorText: Colors.red,
        );
      } catch (e) {
        // General errors
        print("Error occurred during registration: $e");
        Get.snackbar(
          "Error",
          "An error occurred during registration. Please try again.",
          colorText: Colors.red,
        );
      } finally {
        // Reset loading state
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // Form validation failed
      print("Form validation failed");
      Get.snackbar(
        "Validation Error",
        "Please check your input and try again.",
        colorText: Colors.red,
      );
    }
  }
}
