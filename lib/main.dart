import 'package:cosmetics_app/views/auth/login.dart';
import 'package:cosmetics_app/on_boarding.dart';
import 'package:cosmetics_app/splash.dart';
import 'package:flutter/material.dart';

import 'core/logic/helper_method.dart';

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
      home: SplashView(),
      navigatorKey: navKey,
    );
  }
}
