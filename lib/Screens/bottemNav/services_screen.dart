import 'package:brothers_digi/utils/Routes/routes_screen.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedServiceCard extends StatefulWidget {
  @override
  _AnimatedServiceCardState createState() => _AnimatedServiceCardState();
}

class _AnimatedServiceCardState extends State<AnimatedServiceCard> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Animation delay for smooth entry
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: CustomColor.primaryColor,
        title: Text("Our Services",style: TextStyle(
            fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Get.toNamed(Routes.appdev);
                },
                child: _serviceCard(context,"App\nDevelopement",
                    "Cross Platform android & IOS\nHigh and technology",
                    "assets/svg/app-development_2335265.png"),
              ),
              InkWell(
                onTap: (){
                  Get.toNamed(Routes.webdev);
                },
                child: _serviceCard(context,"Web\nDevelopement",
                    "Cross Platform android & IOS\nHigh and technology",
                    "assets/svg/html_856148.png"),
              ),
              InkWell(
                onTap: (){
                  Get.toNamed(Routes.digitalmarketing);
                },
                child: _serviceCard(context,"Digital\nMarketing",
                    "Cross Platform android & IOS\nHigh and technology",
                    "assets/svg/digital-marketing_12688066.png"),
              ),
              InkWell(
                onTap: (){
                  Get.toNamed(Routes.graphicdesign);
                },
                child: _serviceCard(context,"Graphic\nDesigning",
                    "Cross Platform android & IOS\nHigh and technology",
                    "assets/svg/graphic-designer_2219536.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _serviceCard(BuildContext context, String title, String description, String image) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.20, // Fixing the height
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            top: _isVisible ? 0 : 50,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 600),
              opacity: _isVisible ? 1 : 0,
              child: Card(
                elevation: 10,
                color: CustomColor.primaryColor,
                child: Container(
                  height: size.height * .17,
                  width: size.width * .90,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "$title",
                          style: TextStyle(
                            color: CustomColor.whitecolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$description",
                          style: TextStyle(
                            color: CustomColor.whitecolor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: _isVisible ? 20 : 70,
            right: _isVisible ? 20 : -50,
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: _isVisible ? 1 : 0,
              child: Image.asset(
                "$image",
                height: 80,
                color: CustomColor.whitecolor,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

