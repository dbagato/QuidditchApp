import 'package:quidditch_app/screens/email_signin_screen.dart';
import 'package:quidditch_app/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const createAccount = '/createAccount';
  static const loginAccount = '/loginAccount';
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
      case loginAccount:
        return _buildRoute(EmailSigninScreen.create);
      default:
        throw Exception("Route does not exist.");
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
