import 'package:brothers_digi/Screens/Services/AppDev/app_devlopment.dart';
import 'package:brothers_digi/Screens/Services/DigitalMarketing/digital_marketing.dart';
import 'package:brothers_digi/Screens/Services/GraphicDesign/graphic_designing.dart';
import 'package:brothers_digi/Screens/Services/WebDev/web_development.dart';
import 'package:brothers_digi/Screens/bottemNav/home_screen.dart';
import 'package:brothers_digi/Screens/bottemnav.dart';
import 'package:brothers_digi/Screens/onbording_screen.dart';
import 'package:brothers_digi/Screens/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  /// COMMON SCREEN
  static const String splashScreen = '/SplashScreen';
  static const String welcomeScreen = '/welcomeScreen';
  static const String onbordingScreen = '/OnboardingScreen';
  static const String bottemNavScreen = '/BottomNavigationBarExample';

  /// HOME SCREEN
  static const String homescreen = '/Home_Screen';

  /// SERVICE SCREEN
  static const String appdev = '/AppDevelopmentServiceScreen';
  static const String webdev = '/WebDevelopmentServiceScreen';
  static const String digitalmarketing = '/DigitalMarketingScreen';
  static const String graphicdesign = '/GraphicDesignScreen';

  static var list = [
    /// Common screen
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
    ),

    GetPage(
      name: onbordingScreen,
      page: () => OnboardingScreen(),
    ),

    GetPage(
      name: bottemNavScreen,
      page: () => BottomNavigationBarExample(),
    ),



    ///HOME SCREEN SCREEN

    GetPage(
      name: homescreen,
      page: () => Home_Screen(),
    ),


    /// SERVICES ROUTES
    GetPage(
      name: appdev,
      page: () => AppDevelopmentServiceScreen(),
    ),

    GetPage(
      name: webdev,
      page: () => WebDevelopmentServiceScreen(),
    ),

    GetPage(
      name: digitalmarketing,
      page: () => DigitalMarketingScreen(),
    ),

    GetPage(
      name: graphicdesign,
      page: () => GraphicDesignScreen(),
    ),
  ];
}
