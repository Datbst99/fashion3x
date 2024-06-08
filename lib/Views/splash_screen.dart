import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Configs/constant.dart';
import '../Configs/router.dart';


class SplashScreen extends StatefulWidget {


  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage(imageLogo),
          width: 130,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 3));
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacementNamed(context, RouteApp.productShow);
    }else {
      Navigator.pushReplacementNamed(context, RouteApp.login);
    }
  }

}
