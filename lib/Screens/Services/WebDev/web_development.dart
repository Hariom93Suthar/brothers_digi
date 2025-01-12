import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';

class WebDevelopmentServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Web Development Service',style: TextStyle(color: Colors.white),),
        backgroundColor: CustomColor.primaryColor,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Professional Web Development',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 600 ? 28 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We create modern, responsive, and user-friendly websites tailored to your business needs. Choose from our different packages designed for startups, small businesses, and e-commerce.',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 600 ? 18 : 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),

                  Column(
                    children: [
                      buildServiceCard(
                        context,
                        constraints,
                        title: 'Startup Website',
                        description: 'Perfect for small businesses starting out.',
                        price: '₹20,000',
                        icon: Icons.work,
                        color1: Colors.teal,
                        color2: Colors.tealAccent,
                      ),
                      SizedBox(width: 16),
                      buildServiceCard(
                        context,
                        constraints,
                        title: 'Small Business',
                        description: 'Ideal for mid-sized businesses.',
                        price: '₹10,000',
                        icon: Icons.home,
                        color1: Colors.orange,
                        color2: Colors.orangeAccent,
                      ),
                      SizedBox(width: 16),
                      buildServiceCard(
                        context,
                        constraints,
                        title: 'E-Commerce Website',
                        description: 'Comprehensive solution for online stores.',
                        price: '₹35,000',
                        icon: Icons.shopping_cart,
                        color1: Colors.green,
                        color2: Colors.lightGreenAccent,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Our Process',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 600 ? 24 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. Requirement Analysis: Understand your business goals.\n'
                        '2. Design: Create a modern, visually appealing design.\n'
                        '3. Development: Build the website using latest technologies.\n'
                        '4. Testing: Ensure compatibility and performance.\n'
                        '5. Deployment: Launch your website and provide ongoing support.',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 600 ? 18 : 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Add your contact or buy action here
                      },
                      child: Text(
                        'Contact Us',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildServiceCard(
      BuildContext context,
      BoxConstraints constraints, {
        required String title,
        required String description,
        required String price,
        required IconData icon,
        required Color color1,
        required Color color2,
      }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width*.85,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: constraints.maxWidth > 600 ? 48 : 36,
                color: Colors.white,
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 20 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 16 : 12,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                price,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 18 : 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Add buy now action here
                },
                child: Text(
                  'Order Now',
                  style: TextStyle(
                    fontSize: constraints.maxWidth > 600 ? 16 : 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
