import 'package:cosmetics_app/core/constants/app_colors.dart';
import 'package:cosmetics_app/core/utils/helper_method.dart';
import 'package:cosmetics_app/core/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/presentation/home_screen.dart';
import '../logic/auth_cubit.dart';

class VerifyCode extends StatelessWidget {
  final String countryCode;
  final String phoneNumber;
  final String email;
  final String token;

  const VerifyCode({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: Theme.of(
        context,
      ).textTheme.displayLarge?.copyWith(fontSize: 16),
      decoration: BoxDecoration(
        // color: Colors.grey,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red, width: 1.5),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red, width: 1.5),
    );

    return BlocProvider(
      create: (context) => VerifyCodeCubit(),

      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(13),
            child: Center(
              child: BlocConsumer<VerifyCodeCubit, AuthState>(
                listener: (context, state) {
                  if (state is VerifyCodeError){
                    showMsg(state.message);

                  } else if (state is VerifyCodeSuccess){
                    showMsg("Login successful!");
                    goTo(page: HomeScreen(), canPop: false);
                  }
                },

                builder: (context, state) {
                  final cubit = context.read<VerifyCodeCubit>();

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Layer_1_67_x_62.png"),

                        const SizedBox(height: 40),

                        Text(
                          "Verify Code",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),

                        const SizedBox(height: 40),

                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text:
                                "We just sent a 4-digit verification code to your email ",
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: email,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    " Enter the code in the box below to continue.",
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        Pinput(
                          controller: cubit.otpController,
                          length: 4,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          showCursor: true,
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 2,
                                height: 24,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 43),

                        Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "Didn’t receive a code? ",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: 12,
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                children: [
                                  TextSpan(
                                    text: "Resend",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontSize: 12,
                                          color: AppColors.primaryButton,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),

                            const Spacer(),

                            Text("0:36"),
                          ],
                        ),

                        const SizedBox(height: 113),

                        SharedAuthButton(
                          text: "Done",
                          onPressed: () {
                            cubit.verifyCode(
                              countryCode: countryCode,
                              phoneNumber: phoneNumber,
                              token: token,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
