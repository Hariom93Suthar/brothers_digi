import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserServicesScreen extends StatefulWidget {
  @override
  _UserServicesScreenState createState() => _UserServicesScreenState();
}

class _UserServicesScreenState extends State<UserServicesScreen> {
  // Initialize FirebaseAuth and Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late Future<List<Map<String, dynamic>>> userServices;

  @override
  void initState() {
    super.initState();
    userServices = fetchUserServices();
  }

  Future<List<Map<String, dynamic>>> fetchUserServices() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        throw Exception("User is not logged in.");
      }

      String userId = currentUser.uid;

      // Fetch user document from Firestore
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(userId).get();

      if (userDoc.exists) {
        List<dynamic>? services = userDoc.get("services");

        if (services != null) {
          return List<Map<String, dynamic>>.from(services);
        }
      }

      return [];
    } catch (e) {
      print("Error fetching services: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch services. Please try again.",
        colorText: Colors.red,
      );
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColor.primaryColor,
        centerTitle: true,
        title: Text("Your Services",style: TextStyle(
            fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: userServices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text("No services found"));
          } else {
            List<Map<String, dynamic>> services = snapshot.data!;

            return ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                var service = services[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
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
                        Text(
                          service['serviceName'] ?? 'Service Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Price: ${service['price'] ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Created At: ${service['startedAt'] ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Expires At: ${service['expireAt'] ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            // Handle Buy or further action here
                            print("Buying ${service['name']}");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "See More",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
