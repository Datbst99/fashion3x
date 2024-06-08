
import 'package:fashion_3x/Models/product_model.dart';
import 'package:fashion_3x/Views/Authentication/login_screen.dart';
import 'package:fashion_3x/Views/Authentication/register_screen.dart';
import 'package:fashion_3x/Views/Product/create_screen.dart';
import 'package:fashion_3x/Views/Product/edit_screen.dart';
import 'package:fashion_3x/Views/Product/show_screen.dart';
import 'package:fashion_3x/Views/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteApp {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
  static const String productShow = "/productShow";
  static const String productCreate = "/productCreate";
  static const String productEdit = "/productEdit";

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteApp.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouteApp.register:
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case RouteApp.home:
        return MaterialPageRoute(builder: (context) => ProductShowScreen());
      case RouteApp.productShow:
        return MaterialPageRoute(builder: (context) => ProductShowScreen());
      case RouteApp.productCreate:
        return MaterialPageRoute(builder: (context) => ProductCreateScreen());
      case RouteApp.productEdit:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(builder: (context) => ProductEditScreen(product: product,));
      default:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  }

}