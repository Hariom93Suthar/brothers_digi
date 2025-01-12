import 'package:brothers_digi/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GraphicDesignController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add service logic
  Future<void> addGraphicDesignService(String serviceName,String price) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        throw Exception("User is not logged in.");
      }

      String userId = currentUser.uid;

      // Calculate service duration (e.g., 6 months validity)
      DateTime now = DateTime.now();
      DateTime expireAt = now.add(Duration(days: 180));

      // Create service object
      Map<String, dynamic> newService = {
        "serviceName": "$serviceName",
        "price" : "$price",
        "startedAt": now.toIso8601String(),
        "expireAt": expireAt.toIso8601String(),
      };

      // Add the service to user's services array in Firestore
      await _firestore.collection("users").doc(userId).update({
        "services": FieldValue.arrayUnion([newService]),
      });

      Get.snackbar(
        "Success",
        "Graphic Design service purchased successfully!",
        colorText: green2CA,
      );
    } catch (e) {
      print("Error adding service: $e");
      Get.snackbar(
        "Error",
        "Failed to purchase Graphic Design service. Please try again.",
        colorText: redE50,
      );
    }
  }

  // Fetch services logic
  Future<List<Map<String, dynamic>>> fetchUserServices() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        throw Exception("User is not logged in.");
      }

      String userId = currentUser.uid;

      // Fetch user document from Firestore
      DocumentSnapshot userDoc =
      await _firestore.collection("users").doc(userId).get();

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
        colorText: redE50,
      );
      return [];
    }
  }
}



///

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// class GraphicDesignController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Payment Service Placeholder (Integrate Razorpay, UPI, etc.)
//   Future<bool> processPayment() async {
//     try {
//       // Call payment gateway API here
//       print("Starting Payment...");
//       await Future.delayed(Duration(seconds: 3)); // Simulate payment processing
//       bool paymentSuccess = true; // Replace with actual payment status
//
//       if (paymentSuccess) {
//         print("Payment Successful!");
//         return true;
//       } else {
//         print("Payment Failed!");
//         return false;
//       }
//     } catch (e) {
//       print("Payment Error: $e");
//       return false;
//     }
//   }
//
//   // Add Service After Payment
//   Future<void> startPaymentAndAddService() async {
//     try {
//       User? currentUser = _auth.currentUser;
//
//       if (currentUser == null) {
//         throw Exception("User is not logged in.");
//       }
//
//       String userId = currentUser.uid;
//
//       // Step 1: Process Payment
//       bool paymentStatus = await processPayment();
//
//       if (paymentStatus) {
//         // Payment Successful
//         DateTime now = DateTime.now();
//         DateTime expireAt = now.add(Duration(days: 180));
//
//         Map<String, dynamic> newService = {
//           "serviceName": "Graphic Design",
//           "startedAt": now.toIso8601String(),
//           "expireAt": expireAt.toIso8601String(),
//         };
//
//         // Step 2: Add service to Firestore
//         await _firestore.collection("users").doc(userId).update({
//           "services": FieldValue.arrayUnion([newService]),
//         });
//
//         Get.snackbar(
//           "Success",
//           "Payment successful! Graphic Design service activated.",
//           colorText: Colors.green,
//         );
//       } else {
//         // Payment Failed
//         Get.snackbar(
//           "Payment Failed",
//           "Transaction unsuccessful. Please try again.",
//           colorText: Colors.red,
//         );
//       }
//     } catch (e) {
//       print("Error: $e");
//       Get.snackbar(
//         "Error",
//         "An error occurred. Please try again.",
//         colorText: Colors.red,
//       );
//     }
//   }
// }

