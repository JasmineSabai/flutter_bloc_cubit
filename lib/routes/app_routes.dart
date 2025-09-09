import 'package:flutter/material.dart';

import '../dto/ads_item.dart';
import '../scenes/landing/view/landing_screen.dart';
import '../scenes/login/view/login_screen.dart';
import '../scenes/splash_screen/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String landing = '/landing';
  static const String profile = '/profile'; // optional

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case landing:
        final args = settings.arguments as List<AdsItem>;
        return MaterialPageRoute(builder: (_) => LandingScreen(items: args));
      case home:
        // return MaterialPageRoute(builder: (_) => HomePage());
      // case profile:
      //   return MaterialPageRoute(builder: (_) => ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static void pushReplacement(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  static void push(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}