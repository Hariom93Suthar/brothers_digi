import 'package:brothers_digi/Backend/Chatbot/ChatBot.dart';
import 'package:brothers_digi/Screens/Authentication/notification_screen.dart';
import 'package:brothers_digi/Screens/drawer/drawer_screen.dart';
import 'package:brothers_digi/Widgets/UiHelper.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home_Screen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Map<String, String>> offers = [
    {
      "title": "App Development Offer",
      "description": "Get started with your mobile app at an exclusive price!",
      "imageURL": "https://images.pexels.com/photos/1181271/pexels-photo-1181271.jpeg"
    },
    {
      "title": "Digital Marketing Offer",
      "description": "Boost your online presence with our exclusive digital marketing offer!",
      "imageURL": "https://images.pexels.com/photos/1181429/pexels-photo-1181429.jpeg"
    },
    {
      "title": "Web Development Offer",
      "description": "Get your business website built with the latest technology at a discounted price!",
      "imageURL": "https://images.pexels.com/photos/1181344/pexels-photo-1181344.jpeg"
    },
  ];



  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        title: Text("Dashboard",style: TextStyle(
            fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
          actions: [
            IconButton(onPressed: (){
              Get.to(NotificationScreen());
            }, icon: Icon(Icons.notification_important,
            color: CustomColor.whitecolor,size: 25,)),
            SizedBox(width: 10,)
          ],
          iconTheme:IconThemeData(color: CustomColor.whitecolor),
          backgroundColor: CustomColor.primaryColor,
          toolbarHeight: screensize.height*.07,
        ),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //   StreamBuilder<QuerySnapshot>(
          //   stream: _firestore.collection('dailyOffers').snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //     if (snapshot.hasError) {
          //       return Center(child: Text('Error loading offers.'));
          //     }
          //     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          //       return Center(child: Text('No offers available.'));
          //     }
          //
          //     List<QueryDocumentSnapshot> offers = snapshot.data!.docs;
          //
          //     return CarouselSlider(
          //       options: CarouselOptions(
          //         height: 200.0,
          //         autoPlay: true,
          //         enlargeCenterPage: true,
          //       ),
          //       items: offers.map((offer) {
          //         final data = offer.data() as Map<String, dynamic>;
          //         return Builder(
          //           builder: (BuildContext context) {
          //             return Card(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(15.0),
          //               ),
          //               elevation: 5.0,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   ClipRRect(
          //                     borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
          //                     child: Image.network(
          //                       data['imageURL'] ?? '',
          //                       height: 120.0,
          //                       width: double.infinity,
          //                       fit: BoxFit.cover,
          //                       errorBuilder: (context, error, stackTrace) {
          //                         return Container(
          //                           height: 120,
          //                           color: Colors.grey[200],
          //                           child: Icon(Icons.image_not_supported),
          //                         );
          //                       },
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Text(
          //                       data['title'] ?? 'No Title',
          //                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //                     child: Text(
          //                       data['description'] ?? 'No Description',
          //                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             );
          //           },
          //         );
          //       }).toList(),
          //     );
          //   },
          // ),
                Center(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 247.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayInterval: Duration(seconds: 3),
                    ),
                    items: offers.map((offer) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(15.0)),
                                  child: Image.network(
                                    offer['imageURL'] ?? '',
                                    height: 120.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 120,
                                        color: Colors.grey[200],
                                        child: Icon(Icons.image_not_supported),
                                      );
                                      },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    offer['title'] ?? '',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    offer['description'] ?? '',
                                    style:
                                    TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  ),
                                ),
                              ],
                            ),
                          );
                          },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 25,),
                Row(
                  children: [
                    Column(
                      children: [
                        UiHelper.roundcontainer("assets/images/slogo.png"),
                        SizedBox(height: 10,),
                        Text("Simple Logo",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        UiHelper.roundcontainer("assets/images/3dlogo.png"),
                        SizedBox(height: 10,),
                        Text("3D Logo",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        UiHelper.roundcontainer("assets/images/seo.png"),
                        SizedBox(height: 10,),
                        Text("SEO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Column(
                      children: [
                        UiHelper.roundcontainer("assets/images/smm.png"),
                        SizedBox(height: 10,),
                        Text("AppD",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        UiHelper.roundcontainer("assets/images/web.png"),
                        SizedBox(height: 10,),
                        Text("WebD",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        UiHelper.roundcontainer("assets/images/seeAll.png"),
                        SizedBox(height: 10,),
                        Text("See All",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10)),
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent, // FAB background color
          onPressed: () {
            Get.to(ChatBotScreen(),
            transition: Transition.native,
            duration: Duration(seconds: 2));
            },
          child: Lottie.asset(
            'assets/lottie/Animation - 1734089459030.json', // Replace with your Lottie file
            width: 63, // Adjust size for Lottie
            height: 63,
          ),
        ),
      ),
    );
  }
}
