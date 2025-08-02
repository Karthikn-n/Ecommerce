import 'package:e_commerce/ui/cart_screen.dart';
import 'package:e_commerce/ui/home_screen.dart';
import 'package:e_commerce/ui/profile_screen.dart';
import 'package:e_commerce/ui/search_screen.dart';
import 'package:e_commerce/ui/signin_screen.dart';
import 'package:e_commerce/ui/signup_screen.dart';
import 'package:e_commerce/widgets/common/bottom_widget.dart';
import 'package:flutter/material.dart';
class AppRouter {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String nav ="/nav";
  static const String search = '/search';
  static const String profile = '/profile';
  static const String cart = '/cart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case nav:
        return MaterialPageRoute(builder: (_) => BottomWidget(),);
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen(),);
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen(),);
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen(),);
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen(),);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
