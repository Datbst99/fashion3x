import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Configs/constant.dart';
import 'Configs/router.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // Config theme cho app
    return MaterialApp(
      title: 'Fashion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: backColor),
        scaffoldBackgroundColor: backColor,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: textColor),
          bodyMedium: TextStyle(color: textColor),
          bodySmall: TextStyle(color: textColor),
        ),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          color: primaryColor,
          titleTextStyle: TextStyle(
              color: whiteColor, fontSize: 20, fontWeight: FontWeight.w500),
          centerTitle: true,
        ),
      ),
      // Sử dụng route để quản lý luông cho rõ ràng
      onGenerateRoute: RouteApp.generateRoute,
    );
  }
}


