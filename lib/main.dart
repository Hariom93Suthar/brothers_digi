import 'package:brothers_digi/utils/Routes/routes_screen.dart';
import 'package:brothers_digi/Screens/splash_screen.dart';
import 'package:brothers_digi/Screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCERsxG5XQEQbzC_Ob3Yyb6M1W6OQEZrto",
            authDomain: "brothersdigi-5befc.firebaseapp.com",
            projectId: "brothersdigi-5befc",
            storageBucket: "brothersdigi-5befc.firebasestorage.app",
            messagingSenderId: "468235973215",
            appId: "1:468235973215:web:2ecb238206b88f4aefe1ea",
            measurementId: "G-34VHXW5GVQ"
        ));
  }
  else{
    await Firebase.initializeApp();
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.splashScreen,
      getPages: Routes.list,
    );
  }
}