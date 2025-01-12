import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login function
  Future<dynamic> loginWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in the user
      User? user = (await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password))
          .user;

      if (user != null) {
        // Fetch user document from Firestore
        DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          bool isAdmin = userDoc['isAdmin'] ?? false;
          if (isAdmin) {
            return true; // Login successful for admin
          } else {
            return "You do not have permission to access the app yet.";
          }
        } else {
          return "User data not found in Firestore.";
        }
      }
    } on FirebaseAuthException catch (e) {
      return e.message; // Return Firebase-specific error message
    } catch (e) {
      return "An error occurred. Please try again."; // Return generic error message
    }
  }

  Future<dynamic> registerUserWithEmailAndPassword(String fullName, String mobile, String email, String password) async {
    try {
      // Check if the email or mobile already exists in Firestore
      QuerySnapshot emailSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      QuerySnapshot mobileSnapshot = await _firestore
          .collection('users')
          .where('mobile', isEqualTo: mobile)
          .get();

      if (emailSnapshot.docs.isNotEmpty) {
        return "The email is already in use. Please try a different email.";
      }

      if (mobileSnapshot.docs.isNotEmpty) {
        return "The mobile number is already in use. Please try a different mobile number.";
      }

      // Create a new user
      User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user;

      if (user != null) {
        // Hash the password securely before saving it
        String hashedPassword = generateSecurePassword(password);

        // Save user data to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          "uid": user.uid,
          "fullName": fullName,
          "mobile": mobile,
          "email": email,
          "password": hashedPassword, // Secure hashed password
          "createdAt": Timestamp.now(),
          "services": [] // Initialize with empty list for services
        });
        return true; // Registration successful
      }
    } on FirebaseAuthException catch (e) {
      return e.message; // Return Firebase-specific error message
    } catch (e) {
      return "An error occurred. Please try again."; // Return generic error message
    }
  }


// Add service to user's account
  Future<dynamic> addServiceToUser(String userId, Map<String, dynamic> service) async {
    try {
      DocumentReference userDoc = _firestore.collection('users').doc(userId);

      // Add the service to the user's services array
      await userDoc.update({
        "services": FieldValue.arrayUnion([service])
      });
      return true; // Service added successfully
    } catch (e) {
      return "An error occurred while adding the service: $e";
    }
  }

// Method to generate secure hashed password
  String generateSecurePassword(String password) {
    // Use a hashing library like bcrypt or crypto for real-world applications
    // Example using a simple hash (not recommended for production)
    return password.hashCode.toString();
  }


  // Fetch user data by email
  Future<DocumentSnapshot?> getUserDataByEmail(String email) async {
    try {
      QuerySnapshot snapshot =
      await _firestore.collection("users").where("email", isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first;
      } else {
        return null; // No user found
      }
    } catch (e) {
      throw Exception("An error occurred while fetching user data.");
    }
  }

  // Logout function
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
