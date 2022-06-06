import 'package:quidditch_app/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const createAccount = '/createAccount';
  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case intro:
        return _buildRoute(IntroScreen.create);
      case home:
        return _buildRoute(HomeScreen.create);
      case createAccount:
        return _buildRoute(CreateAccountScreen.create);
      default:
        throw Exception("Route does not exist.");
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
