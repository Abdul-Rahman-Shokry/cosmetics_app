import 'package:cosmetics_app/core/utils/helper_methods.dart';
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

  // TODO
  // final _secureStorage = const FlutterSecureStorage();


  // @override
  // void initState() {
  //   super.initState();
  //   _checkUserLoginStatus();
  // }
  //
  // Future<void> _checkUserLoginStatus() async {
  //   final String? token = await _secureStorage.read(key: 'token');
  //
  //   await Future.delayed(const Duration(seconds: 3));
  //
  //   if(mounted){
  //     if(token != null && token.isNotEmpty){
  //       goTo(page: MainLayoutScreen(), canPop: false);
  //     } else {
  //       goTo(page: OnBoarding(), canPop: false);
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      goTo(page: const OnBoarding(), canPop: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppImage("Layer_1.png", width: 200, height: 200),
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
