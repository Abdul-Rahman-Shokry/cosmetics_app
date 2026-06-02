import 'package:cosmetics_app/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'on_boarding.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => OnBoarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImage("Layer_1.png", width: 200, height: 200),
            const SizedBox(height: 20),
            Text(
              'COSMATICS',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 15,
                letterSpacing: 15 * 0.30,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 7.06),
            Text(
              'The company for woman',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
