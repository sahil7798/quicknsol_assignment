import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknsol_assignment/view/home/home_screen.dart';
import 'package:quicknsol_assignment/view/login/login_screen.dart';
import 'package:quicknsol_assignment/view/signUp/signUp_screen.dart';
import 'package:quicknsol_assignment/view/splash/splash_screen.dart';
import 'package:quicknsol_assignment/view/update_user/updateUser_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quicknsol Assignment',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
            useMaterial3: true,
          ),
          home: const SplashScreen()),
    );
  }
}
