import 'package:flutter/material.dart';

import '../auth/signin/view/signin_page.dart';
import '../auth/signup/view/signup_page.dart';
import '../bhajanplayer/view/bhajanplayer_page.dart';
import '../home/view/home_page.dart';
import '../splash/view/splash_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (BuildContext context) => const SplashPage(),
    '/signin': (BuildContext context) => const SignInPage(),
    '/signup': (BuildContext context) => const SignUpPage(),
    '/home': (BuildContext context) => const HomePage(),
    '/bhajanplay': (BuildContext context) => const BhajanPlayerPage(),
  };
}
