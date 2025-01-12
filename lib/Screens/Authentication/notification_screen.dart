import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: CustomColor.primaryColor,
        title: Text("All Notifications",style: TextStyle(
          color: CustomColor.whitecolor
        ),),
      ),
      body: Container(
        color: Colors.white, // Background color
        child: Center(
          child: Lottie.asset(
            'assets/lottie/Animation - 1727687458840.json', // Animation file
            width: 200, // Adjust size as needed
            height: 200,
          ),
        ),
      ),
    );
  }
}
