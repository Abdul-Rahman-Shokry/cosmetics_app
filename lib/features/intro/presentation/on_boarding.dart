import 'package:cosmetics_app/core/utils/helper_method.dart';
import 'package:cosmetics_app/core/constants/app_colors.dart';
import 'package:cosmetics_app/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

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
      width: 383.68,
      height: 259.6,
    ),
    _Model(
      image: "assets/images/on_boarding2.png",
      title: "SEARCH & PICK",
      subTitle:
          "We have dedicated set of products and routines hand picked for every skin type.",
      width: 314.8,
      height: 288.08,
    ),
    _Model(
      image: "assets/images/on_boarding3.png",
      title: "PUSH NOTIFICATIONS",
      subTitle: "Allow notifications for new makeup & cosmetics offers.",
      width: 253,
      height: 253,
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
              Visibility(
                visible: !isLast,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        goTo(page: LoginScreen(), canPop: false);
                      },
                      child: Text(
                        "Skip",
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(currentModel.image, width: currentModel.width, height: currentModel.height),
                    const SizedBox(height: 20),
                    Text(
                      currentModel.title,
                      style: Theme.of(context,).textTheme.displayLarge?.copyWith(
                        fontSize: 16,
                        fontFamily: 'Segoe-UI',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Added Padding and TextAlign to make the long text look much better
                    SizedBox(
                      width: 308,
                      child: Text(
                        currentModel.subTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 16,
                          fontFamily: 'Segoe-UI',
                          fontWeight: FontWeight.w400,
                        ),
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
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryText,
                              fixedSize: Size(268, 65),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
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
                              backgroundColor: AppColors.primaryText,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
  final double width, height;

  _Model({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.width,
    required this.height,
  });
}
