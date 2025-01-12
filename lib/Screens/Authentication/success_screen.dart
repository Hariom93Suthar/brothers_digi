import 'package:brothers_digi/utils/Routes/routes_screen.dart';
import 'package:brothers_digi/Screens/bottemNav/home_screen.dart';
import 'package:brothers_digi/Widgets/customWidget.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueAccent.withOpacity(0.7),
              Colors.purpleAccent.withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animated Success Icon
            ScaleTransition(
              scale: _animation,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40),

            // Success Message
            Text(
              'Registration Successful!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Additional Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Your registration is successful! However, you can access the application only after receiving approval from the admin. Please wait for confirmation.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height*.50),

            // Go to Home Button
            InkWell(
              onTap: (){
                Get.toNamed(Routes.homescreen);
              },
                child: CustomButtonWidget.button(context,"Go to Home",CustomColor.primaryColor,CustomColor.whitecolor)),
          ],
        ),
      ),
    );
  }
}