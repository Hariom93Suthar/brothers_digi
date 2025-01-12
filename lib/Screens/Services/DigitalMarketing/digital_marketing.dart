import 'package:brothers_digi/Widgets/customWidget.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DigitalMarketingScreen extends StatelessWidget {
  final List<Map<String, String>> campaigns = [
    {
      'name': 'Instagram Ad Campaign',
      'description': 'Boost your brand on Instagram with targeted ads.',
      'price': '₹15,000',
      'image': 'assets/svg/insta.svg',
    },
    {
      'name': 'Facebook Ad Campaign',
      'description': 'Reach a wider audience with Facebook ads.',
      'price': '₹12,000',
      'image': 'assets/svg/fecbook.svg',
    },
    {
      'name': 'Google Ad Campaign',
      'description': 'Appear on Google search results and more.',
      'price': '₹20,000',
      'image': 'assets/svg/google.svg',
    },
    {
      'name': 'WhatsApp Business Ad Campaign',
      'description': 'Connect directly with customers via WhatsApp.',
      'price': '₹10,000',
      'image': 'assets/svg/whatsapp.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Digital Marketing Services',style: TextStyle(color: Colors.white),),
        backgroundColor: CustomColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Digital Marketing Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We offer a variety of marketing campaigns to help you grow your business:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: campaigns.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueAccent.withOpacity(0.8),
                            Colors.purple.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            campaigns[index]['image']!,
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  campaigns[index]['name']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  campaigns[index]['description']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            campaigns[index]['price']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomButtonWidget.button1(context,"Contact Us", CustomColor.primaryColor, white)
          ],
        ),
      ),
    );
  }
}
