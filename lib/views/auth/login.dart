import 'package:flutter/material.dart';

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/login_img.png"),
                Text("Login Now"),
                Text("Please enter the details below to continue")
              ],
            ),
          )
      ),
    );
  }
}