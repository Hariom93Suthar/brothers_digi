import 'package:brothers_digi/Controllers/GraphicDesignController/graphic_design_controller.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class GraphicDesignScreen extends StatefulWidget {
  @override
  State<GraphicDesignScreen> createState() => _GraphicDesignScreenState();
}

class _GraphicDesignScreenState extends State<GraphicDesignScreen> {
  Map<int, bool> boughtServices = {};

  final GraphicDesignController  controller = Get.put(GraphicDesignController());

  final List<Map<String, String>> services = [
    {
      'name': 'Simple Logo Design',
      'price': '₹500',
      'description': 'A simple, professional logo design for your brand.',
    },
    {
      'name': '3D Logo Design',
      'price': '₹2000',
      'description': 'A creative and futuristic 3D logo for your brand.',
    },
    {
      'name': 'Poster Design',
      'price': '₹1500',
      'description': 'Custom poster design with unique artwork and text.',
    },
    {
      'name': 'Instagram Post Design',
      'price': '₹1000',
      'description': 'Designs for Instagram posts to boost your social media presence.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Graphic Design Services',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: CustomColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Graphic Design Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We offer a variety of graphic design services to enhance your brand image:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 180,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                pauseAutoPlayOnTouch: true,
              ),
              items: [
                OfferCard('Monthly ₹999', '300 Posts', Colors.green),
                OfferCard('1 Year ₹3999', '1500 Posts', Colors.blue),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple.withOpacity(0.8),
                            Colors.pink.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.design_services,
                                color: Colors.white,
                                size: 45,
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      services[index]['name']!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      services[index]['description']!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            services[index]['price']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (boughtServices[index] == true) {
                                // Navigate to service page if already bought
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServiceDetailsPage(),
                                  ),
                                );
                              } else {
                                // Handle the Buy action
                                controller.addGraphicDesignService("${services[index]['name']}", "${services[index]['price']}");

                                // Mark the service as bought
                                setState(() {
                                  boughtServices[index] = true;
                                });

                                // You can show a success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Service bought successfully')),
                                );
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: boughtServices[index] == true ? Colors.green : Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                boughtServices[index] == true ? "Already Bought" : "Buy",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget OfferCard(String title, String subtitle, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceDetailsPage extends StatelessWidget {

  ServiceDetailsPage();

  @override
  Widget build(BuildContext context) {
    // Fetch the service details using serviceId and display them
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Details"),
      ),
      body: Center(
        child: Text("Service Details for ID:"),
      ),
    );
  }
}
