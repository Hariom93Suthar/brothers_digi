import 'dart:ui';
import 'package:brothers_digi/Screens/onbording_screen.dart';
import 'package:brothers_digi/Widgets/UiHelper.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List imglist = [
    {"id": 1, "imgpath": "assets/images/Hii.gif"},
    {"id": 2, "imgpath": "assets/images/next.png"}
  ];
  final CarouselSliderController controller = CarouselSliderController();
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    // Responsive height and width helpers
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05, left: screenWidth * 0.05),
            child: UiHelper.color(
              "Welcome\nUser",
              const Color(0xFF34C31D),
              const Color(0xFF0F0500),
              const Color(0xFFE83810),
              Colors.purpleAccent,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05),
            child: Image.asset(
              "assets/images/bds1.gif",
              color: CustomColor.primaryColor,
              height: screenHeight * 0.4,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.25),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: screenHeight * 0.5,
                enlargeCenterPage: true,
              ),
              items: imglist.map((i) {
                return Image.asset(
                  i['imgpath'],
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.8,
                  fit: BoxFit.contain,
                );
              }).toList(),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(OnboardingScreen());
            },
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.85),
              child: Center(
                child: Container(
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.85,
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "Ubuntu-Regular",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
