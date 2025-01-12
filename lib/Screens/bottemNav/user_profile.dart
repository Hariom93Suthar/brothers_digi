import 'package:brothers_digi/Screens/profile/change_password.dart';
import 'package:brothers_digi/Screens/profile/edit_profile_screen.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColor.primaryColor,
        centerTitle: true,
        title: Text("Profile",style: TextStyle(
            fontWeight: FontWeight.w700,color: Colors.white,fontSize: 20),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              backgroundColor: Colors.indigo,
              radius: 50,
              child: Icon(Icons.person,size: 40,),
            ),
            SizedBox(height: 10,),
            Center(
              child: Text("Here User Name",style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold,
              ),),
            ),
            Center(
              child: Text("Here User Email",style: TextStyle(
                fontSize: 20,
              ),),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.only(left: 30,top: 10),
                child: Text("General Setting",style: TextStyle(
                    color: Colors.black26,fontWeight: FontWeight.w700,fontSize: 18
                ),),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(EditProfilePage());
              },
                child:
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: ListTile(
                      trailing: Icon(Icons.arrow_forward_ios),
                      leading: Icon(Icons.edit, size: 30),
                      title: Text("Edit Profile", style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                ),
            InkWell(
              onTap: (){
                Get.to(ChangePasswordScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10,left: 20),
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios),
                  leading: Icon(Icons.key_sharp,size: 30),
                  title: Text("Change Password",style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500
                  ),),
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.only(left: 32,top: 10),
                child: Text("Information",style: TextStyle(
                    color: Colors.black26,fontWeight: FontWeight.w700,fontSize: 18
                ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20),
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.phone_android,size: 30,),
                title: Text("About Us",style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w500
                ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20),
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.terminal,size: 30,),
                title: Text("Terms & Conditions",style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w500
                ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20),
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.privacy_tip,size: 30,),
                title: Text("Privacy Policy",style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w500
                ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20),
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.share,size: 30,),
                title: Text("Share This App",style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w500
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
