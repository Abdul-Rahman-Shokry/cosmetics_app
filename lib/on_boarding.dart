import 'package:cosmetics_app/core/logic/helper_method.dart';
import 'package:cosmetics_app/views/auth/login.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final list = [
    _Model(
      image: "assets/images/on_boarding1.png",
      title: "WELCOME!",
      subTitle:
          "Makeup has the power to transform your mood and empowers you to be a more confident person.",
    ),
    _Model(
      image: "assets/images/on_boarding2.png",
      title: "SEARCH & PICK",
      subTitle:
          "We have dedicated set of products and routines hand picked for every skin type.",
    ),
    _Model(
      image: "assets/images/on_boarding3.png",
      title: "PUCH NOTIFICATIONS",
      subTitle: "Allow notifications for new makeup & cosmetics offers.",
    ),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isLast = currentIndex == list.length - 1;
    final currentModel = list[currentIndex];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              if (!isLast)
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      goTo(page: Login(), canPop: false);
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(currentModel.image, width: 300, height: 300),
                    const SizedBox(height: 20),
                    Text(
                      currentModel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Added Padding and TextAlign to make the long text look much better
                    Text(
                      currentModel.subTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Pushes the content slightly up so it's not perfectly centered mathematically, which often looks better visually
                    const SizedBox(height: 25),

                    isLast
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff434C6D),
                            ),
                            child: Text(
                              "let's start!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              currentIndex++;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Colors.white,
                            ),
                            style: IconButton.styleFrom(
                              iconSize: 30,
                              backgroundColor: Color(0xff434C6D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Model {
  final String image, title, subTitle;

  _Model({required this.image, required this.title, required this.subTitle});
}
