import 'package:brothers_digi/Screens/Authentication/logout_screen.dart';
import 'package:brothers_digi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/uihelper.dart';
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
 AuthHelper authHelper = AuthHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              Container(
                color: Colors.blueAccent,
                height: 200,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person,size: 40,),
                  ),
                  title: Text("User Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                  subtitle: Text("brotherdigi@321gmail.com",style: TextStyle(color: Colors.white),),
                ),
              ),
              UiHelper.listtile("Home Page",Icons.home_filled,),
              UiHelper.listtile("favourite Services",Icons.favorite),
              UiHelper.listtile("Our Services",Icons.medical_services_rounded),
              UiHelper.listtile("More Info",Icons.info),
              UiHelper.listtile("About Us",Icons.account_box),
              SizedBox(height: 300,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  authHelper.logoutWithSnackbar(context);
                },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Icon(Icons.logout,color: CustomColor.redcolor,size: 25,),
                        SizedBox(width: 7,),
                        Text("Log Out",style: TextStyle(
                          color: CustomColor.redcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),),
                      ],
                    ),
                  ))
            ],
          ),
        ),
    );
  }
}
