import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';

class AppDevelopmentServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('App Development Service',style: TextStyle(color: Colors.white),),
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
                    'Professional App Development',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 600 ? 28 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We specialize in creating high-quality apps using Flutter and Firebase. From dynamic apps with admin panels to simple one-time applications, we provide tailored solutions for your business.',
                    style: TextStyle(
                      fontSize: constraints.maxWidth > 600 ? 18 : 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      buildServiceCard(
                        constraints,
                        title: 'With Admin Panel',
                        description: 'Full-featured apps with admin panel to manage users, content, and analytics.',
                        price: 'Starting at ₹50,000',
                        color1: Colors.deepPurple,
                        color2: Colors.purpleAccent,
                      ),
                      buildServiceCard(
                        constraints,
                        title: 'Without Admin Panel',
                        description: 'Cost-effective apps for specific use cases without admin features.',
                        price: 'Starting at ₹30,000',
                        color1: Colors.blue,
                        color2: Colors.lightBlueAccent,
                      ),
                      buildServiceCard(
                        constraints,
                        title: 'One-Time Applications',
                        description: 'Simple apps for events or specific short-term needs.',
                        price: 'Starting at ₹15,000',
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
                    '1. Requirement Gathering: Understand your needs and goals.\n'
                        '2. Design: Create a modern and user-friendly UI/UX.\n'
                        '3. Development: Use Flutter and Firebase for efficient app creation.\n'
                        '4. Testing: Ensure the app is error-free and performs well.\n'
                        '5. Deployment: Launch the app and provide post-launch support.',
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
      BoxConstraints constraints, {
        required String title,
        required String description,
        required String price,
        required Color color1,
        required Color color2,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        child: Container(
          width: constraints.maxWidth > 600 ? 500 : double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 24 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 18 : 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 16),
              Text(
                price,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 20 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

