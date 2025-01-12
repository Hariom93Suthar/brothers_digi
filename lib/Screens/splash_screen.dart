import 'dart:async';
import 'package:brothers_digi/Screens/bottemnav.dart';
import 'package:brothers_digi/Screens/welcome_screen.dart';
import 'package:brothers_digi/Widgets/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  void checkUserStatus() async {
    await getUserLoggedInStatus();
    Timer(const Duration(seconds: 3), () {
      Get.to(WelcomeScreen());
      if (_isSignedIn) {
        Get.off(BottomNavigationBarExample());
      } else {
        Get.off(WelcomeScreen());
      }
    });
  }

  Future<void> getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade700,
      body: Center(
          child: Image.asset("assets/images/splashbd.gif",color: Colors.white,)
      ),
    );
  }
}
