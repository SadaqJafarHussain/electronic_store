import 'package:flutter/material.dart';
import '../presentation/After Spalsh Screen/after_splash_screen.dart';
import '../presentation/Splash Screen/splash_screen.dart';

class AppRoutes {
  static const String splashScreen =
      '/splash_screen';

  static const String afterSplashScreen =
      '/after_splash_screen';


  static const String signUpScreen =
      '/sign_up_screen';

  static const String iphone1415ProMaxSixScreen =
      '/iphone_14_15_pro_max_six_screen';

  static const String signInScreen =
      '/sign_in_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    afterSplashScreen: (context) => AfterSplash(),
  };
}
