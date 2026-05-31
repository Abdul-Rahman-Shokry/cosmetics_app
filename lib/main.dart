import 'package:cosmetics_app/core/constants/app_colors.dart';
import 'package:cosmetics_app/splash.dart';
import 'package:flutter/material.dart';
import 'core/utils/helper_method.dart';
import 'features/auth/presentation/verify_code_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            displayLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
          ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashView(),

      // home: VerifyCode(
      //   countryCode: "+20",
      //   phoneNumber: "...",
      //   email: "...",
      //   token: "...",
      // ),

      navigatorKey: navKey,
    );
  }
}
