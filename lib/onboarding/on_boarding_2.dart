import 'package:cosmetics_app/onboarding/on_boarding_3.dart';
import 'package:flutter/material.dart';

class OnBoarding2 extends StatelessWidget{
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 2. Align pushes the button to the top right
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                // 3. TextButton makes it clickable!
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                      Colors.grey, // A good subtle color for a skip button
                    ),
                  ),
                ),
              ),
            ),

            // 4. Expanded takes up the rest of the screen and centers its content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/on_boarding2.png',
                    width: 300,
                    height: 300,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "WELCOME!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  // Added Padding and TextAlign to make the long text look much better
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "Makeup has the power to transform your mood and empowers you to be a more confident person.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Pushes the content slightly up so it's not perfectly centered mathematically, which often looks better visually
                  const SizedBox(height: 25),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OnBoarding3()
                          )
                      );
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
    );
  }
}