import 'package:brothers_digi/Widgets/customWidget.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Animation controllers
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Controllers for TextFormFields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _businessController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final doc =
      await _firestore.collection('users').doc(user.uid).get(); // Replace 'users' with your collection name
      if (doc.exists) {
        final data = doc.data();
        setState(() {
          _nameController.text = data?['fullName'] ?? '';
          _lastNameController.text = data?['last_name'] ?? '';
          _emailController.text = data?['email'] ?? '';
          _mobileController.text = data?['mobile'] ?? '';
          _cityController.text = data?['city'] ?? '';
          _stateController.text = data?['state'] ?? '';
          _businessController.text = data?['business'] ?? '';
        });
        // Start animation once data is loaded
        _animationController.forward();
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': _nameController.text,
          'last_name': _lastNameController.text,
          'email': _emailController.text,
          'mobile': _mobileController.text,
          'city': _cityController.text,
          'state': _stateController.text,
          'business': _businessController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Edit Profile',style: TextStyle(color: CustomColor.whitecolor),),
        backgroundColor: CustomColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image Section
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () {
                            // Implement Profile Image Upload
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*.025 ),
                  Row(
                    children: [
                      Expanded(
                       child: textFormField1(
                         controller: _nameController,
                         prefixIcon: Icon(Icons.drive_file_rename_outline_sharp)
                       ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: textFormField1(
                          controller: _lastNameController,
                          prefixIcon: Icon(Icons.drive_file_rename_outline_sharp),
                          hintText: "Last name"
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height*.020 ),
                  InterMedium(text: "Email",color: Colors.black),
                  SizedBox(height: size.height*.010 ),
                  // Email Field
                  textFormField1(
                    controller: _emailController,
                    readOnly: true,
                    prefixIcon: Icon(Icons.email_outlined)
                  ),
                  SizedBox(height: size.height*.020 ),
                  InterMedium(text: "Phone",color: Colors.black),
                  SizedBox(height: size.height*.010 ),
                  // Mobile Field
                  textFormField1(
                    controller: _mobileController,
                    readOnly: true,
                    prefixIcon: Icon(Icons.phone),

                  ),
                  SizedBox(height: size.height*.020 ),
                  InterMedium(text: "City",color: Colors.black),
                  SizedBox(height: size.height*.010 ),
                  // City Field
                  textFormField1(
                    controller: _cityController,
                    prefixIcon: Icon(Icons.location_city_sharp),
                    hintText: "Enter city name"
                  ),

                  SizedBox(height: size.height*.020 ),
                  InterMedium(text: "State",color: Colors.black),
                  SizedBox(height: size.height*.010 ),
                  // State Field
                  textFormField1(
                    controller: _stateController,
                    prefixIcon: Icon(Icons.account_balance),
                    hintText: "Enter state name"
                  ),
                  SizedBox(height: size.height*.020 ),
                  InterMedium(text: "Business Type",color: Colors.black),
                  SizedBox(height: size.height*.010 ),
                  // Business Field
                  textFormField1(
                    controller: _businessController,
                    prefixIcon: Icon(Icons.business),
                    hintText: "Enter business name"
                  ),
                  SizedBox(height: size.height*.080 ),

                  // Save Button
                  CustomButtonWidget.button1(context,"Save",CustomColor.primaryColor,CustomColor.whitecolor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFormField1({
    prefixIcon,
    controller,
    keyboardType,
    hintText,
    suffix,
    enabled,
    onchange,
    bool isPassword = false, // Password field ka flag
    bool readOnly = false, // Read-only field ka flag
    Function()? onTap, // onTap callback
  }) {
    ValueNotifier<bool> obscureText = ValueNotifier<bool>(isPassword); // Obscure state ke liye

    return ValueListenableBuilder(
      valueListenable: obscureText,
      builder: (context, value, child) {
        return TextFormField(
          enabled: enabled,
          readOnly: readOnly, // Read-only field set
          onTap: onTap, // onTap callback assign
          keyboardType: keyboardType,
          cursorColor: black171,
          controller: controller,
          onChanged: onchange,
          obscureText: value, // Obscure text toggle
          style: TextStyle(
            color: black171,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            suffix: isPassword
                ? IconButton(
              icon: Icon(
                value ? Icons.visibility_off : Icons.visibility, // Toggle icon
                color: greyA6A,
              ),
              onPressed: () {
                obscureText.value = !obscureText.value; // Toggle obscureText
              },
            )
                : suffix, // Agar password field nahi hai toh original suffix use kare
            hintText: hintText,
            hintStyle: TextStyle(
              color: greyA6A,
              fontSize: 14,
            ),
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: whiteF9F,
            contentPadding: EdgeInsets.zero,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: greyA6A, width: 1)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: greyA6A, width: 0.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: greyA6A, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: greyA6A, width: 1)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: redE50, width: 1.5)),
          ),
        );
      },
    );
  }
  Widget InterMedium(
      {String? text, Color? color, double? fontSize, TextAlign? textAlign}) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
      ),
    );
  }
}
