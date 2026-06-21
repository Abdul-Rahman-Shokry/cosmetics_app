import 'package:cosmetics_app/core/constants/app_colors.dart';
import 'package:cosmetics_app/core/network/api_helper.dart';
import 'package:flutter/material.dart';
import 'core/utils/helper_methods.dart';
import 'features/intro/presentation/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: AppColors.background,
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
      // home: CartScreen(),
      navigatorKey: navKey,
    );
  }
}
