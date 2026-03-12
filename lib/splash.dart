import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding/on_boarding1.dart';

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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  OnBoarding()),
      );
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
            Image.asset(
              'assets/images/Layer_1.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'AVON',
              style: TextStyle(
                fontSize: 50,
                letterSpacing: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text('The company for woman'),
          ],
        ),
      ),
    );
  }
}
