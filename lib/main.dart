import 'package:cosmetics_app/onboarding/on_boarding_1.dart';
import 'package:cosmetics_app/onboarding/on_boarding_2.dart';
import 'package:cosmetics_app/onboarding/on_boarding_3.dart';
import 'package:cosmetics_app/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'onboarding/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'LexandPeta-Light'),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
