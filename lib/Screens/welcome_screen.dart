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
  List imglist =[
    {"id":1, "imgpath":"assets/images/Hii.gif"},
    {"id":2, "imgpath":"assets/images/next.png"}
  ];
  final CarouselSliderController controller = CarouselSliderController();
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Stack(
        children: [
          Padding(padding: EdgeInsets.only(top: 50,left: 20),
            child: UiHelper.color(
              "Welcome\nUser",
              Color(0xFF34C31D),
              Color(0xFF0F0500),
              Color(0xFFE83810),
              Colors.purpleAccent
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Image.asset("assets/images/bds1.gif",
              color: CustomColor.primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  height: 650,
                  enlargeCenterPage: true
              ),
              items: imglist.map((i) {
                return Image.asset(
                  i['imgpath'],
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width,
                );
              }).toList(),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(OnboardingScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 750),
              child: Center(
                child: Container(
                  child: Center(
                    child: Text("Get Started",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: "Ubuntu-Regular"
                    ),),
                  ),
                  height: 45,
                  width: MediaQuery.of(context).size.width*.70,
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
