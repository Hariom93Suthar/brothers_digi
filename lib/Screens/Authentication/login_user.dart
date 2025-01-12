import 'package:brothers_digi/Screens/Authentication/registration_user.dart';
import 'package:brothers_digi/Screens/bottemNav/home_screen.dart';
import 'package:brothers_digi/Screens/bottemnav.dart';
import 'package:brothers_digi/Widgets/form_field.dart';
import 'package:brothers_digi/Widgets/helper_function.dart';
import 'package:brothers_digi/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      var userDoc = await _firestore.collection('users').doc(email).get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        String storedPassword = userData['password'];
        bool isAdmin = userData['isAdmin'] ?? false;

        if (storedPassword == password) {
          if (isAdmin) {
            // User is an admin, proceed to the admin panel
            print("Login successful! Navigating to admin panel...");
            Get.to(BottomNavigationBarExample());
          } else {
            // User is not an admin, show an error message
            print("You are not authorized to access the admin panel.");
          }
        } else {
          print("Invalid credentials!");
        }
      } else {
        print("User not found");
      }
    } catch (e) {
      print("Error logging in: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _isLoading
          ?Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      )
          :Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFF0318ae),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/uilogo.png",color: Colors.white,
                height:height*.50,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(padding: EdgeInsets.only(top: 350),
                child: Text("नमस्कार !",style: TextStyle(
                    fontSize: 60,fontWeight: FontWeight.bold,color: Colors.white
                ),),),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height*.50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60,left: 40,right: 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
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
                        SizedBox(height:height*.04,),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                            labelText: "password",
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
                        SizedBox(height:height*.015,),
                        Row(
                          children: [
                            Container(
                              height: 18,width: 18,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(2)
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text("Remember me",style: TextStyle(
                                fontSize: 17,fontWeight: FontWeight.bold),),
                            SizedBox(width: 60,),
                            Text("Forgot Password",style: TextStyle(
                              fontSize: 17,fontWeight: FontWeight.bold,color: Colors.deepPurple,
                            ),),
                          ],
                        ),
                        SizedBox(height: height*.05,),
                        InkWell(
                          onTap: (){
                           login();
                          },
                          child: Container(
                            child: Center(
                              child: Text("LOGIN",style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white
                              ),),
                            ),
                            height: 60,width:double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.indigo
                            ),
                          ),
                        ),
                        SizedBox(height: height*.025,),
                        Text.rich(TextSpan(
                          text: "Don't have an account? ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, fontSize: 19),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {
                                nextscreen(RegistrationScreen());},
                              text: "Register here",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.deepPurple,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ))
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
  login() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Check if AuthService is initialized
        if (authService == null) {
          throw Exception("AuthService is not initialized");
        }

        // Call loginWithEmailAndPassword from AuthService
        var result = await authService.loginWithEmailAndPassword(email, password);

        if (result == true) {
          // Get the current Firebase user
          User? user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            // Fetch user data from Firestore
            DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

            if (userDoc.exists && userDoc['email'] != null) {
              // Save user details in shared preferences
              await HelperFunctions.saveUserLoggedInStatus(true);
              await HelperFunctions.saveUserEmailSF(email);
              await HelperFunctions.saveUserNameSF(userDoc['fullName'] ?? "User");

              // Navigate to the main screen
              Get.to(BottomNavigationBarExample());
            } else {
              // Handle case where user data is missing in Firestore
              Get.snackbar(
                "Error",
                "User data not found in Firestore.",
                colorText: Colors.red,
                duration: Duration(seconds: 5),
              );
            }
          } else {
            // Handle case where Firebase user is null
            Get.snackbar(
              "Error",
              "No user is currently signed in.",
              colorText: Colors.red,
              duration: Duration(seconds: 5),
            );
          }
        } else {
          // Handle invalid login credentials or other errors from AuthService
          Get.snackbar(
            "Login Error",
            result.toString(),
            colorText: Colors.red,
            duration: Duration(seconds: 5),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Firebase-specific error handling
        Get.snackbar(
          "Firebase Error",
          e.message ?? "An error occurred during login.",
          colorText: Colors.red,
          duration: Duration(seconds: 5),
        );
      } catch (e) {
        // General error handling
        Get.snackbar(
          "Error",
          "An unexpected error occurred: $e",
          colorText: Colors.red,
          duration: Duration(seconds: 5),
        );
      } finally {
        // Reset loading state
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // Form validation failed
      Get.snackbar(
        "Validation Error",
        "Please fill in all fields correctly.",
        colorText: Colors.red,
        duration: Duration(seconds: 5),
      );
    }
  }

}
