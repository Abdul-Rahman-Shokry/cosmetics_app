import 'package:cosmetics_app/core/constants/app_colors.dart';
import 'package:cosmetics_app/core/utils/helper_methods.dart';
import 'package:cosmetics_app/core/widgets/app_image.dart';
import 'package:cosmetics_app/core/widgets/auth_button.dart';
import 'package:cosmetics_app/core/widgets/success_dialog.dart';
import 'package:cosmetics_app/features/auth/presentation/login_screen.dart';
import 'package:cosmetics_app/features/auth/presentation/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import '../../home/presentation/home_screen.dart';
import '../logic/auth_state.dart';
import '../logic/verify_code_cubit.dart';


class VerifyCode extends StatelessWidget {
  final String countryCode;
  final String phoneNumber;
  final String? email;
  final String? token;
  final bool isForgotPasswordFlow;

  const VerifyCode({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    this.email,
    this.token,
    this.isForgotPasswordFlow = false,
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
      create: (context) => VerifyCodeCubit()..startTimer(),

      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(13),
            child: Center(
              child: BlocConsumer<VerifyCodeCubit, AuthState>(
                listener: (context, state) {
                  if (state is VerifyCodeError) {
                    showMsg(state.message);
                  } else if (state is VerifyCodeSuccess) {
                    if (isForgotPasswordFlow) {
                      goTo(page: ResetPasswordScreen(
                        countryCode: countryCode,
                        phoneNumber: phoneNumber,
                      ), canPop: false);
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return SuccessDialog(
                                title: "Account Activated",
                                message: "Congratulations! Your account has been successfully activated",
                                buttonText: "Return to login",
                                onPressed: (){
                                  Navigator.pop(context);
                                  goTo(page: LoginScreen(), canPop: false);
                                },
                            );
                          }
                      );
                    }
                  }

                  if(state is ResendOTPError){
                    showMsg(state.message);
                  } else if (state is ResendOTPSuccess){
                    showMsg(state.message);
                  }
                },

                builder: (context, state) {
                  final cubit = context.read<VerifyCodeCubit>();

                  final String displayTime = "0:${cubit.remainingSeconds.toString().padLeft(2, '0')}";

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImage("Layer_1_67_x_62.png"),

                        const SizedBox(height: 40),

                        Text(
                          "Verify Code",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),

                        const SizedBox(height: 40),

                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: email != null
                                ? "We just sent a 4-digit verification code to your email "
                                : "We just sent a 4-digit verification code to your registered account. ",
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              if (email != null)
                                TextSpan(
                                  text: "$email.",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              const TextSpan(
                                text: " Enter the code in the box below to continue.",
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
                                  state is ResendOTPLoading
                                      ? WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: const SizedBox(
                                      height: 12,
                                      width: 12,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primaryButton,
                                      ),
                                    ),
                                  )
                                      : TextSpan(
                                    text: "Resend",
                                    recognizer: cubit.remainingSeconds > 0
                                        ? null
                                        : (TapGestureRecognizer()
                                      ..onTap = () {
                                        cubit.resendOTP(
                                          countryCode: countryCode,
                                          phoneNumber: phoneNumber,
                                          token: token,
                                        );
                                      }),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                      fontSize: 12,
                                      color: cubit.remainingSeconds > 0
                                          ? Colors.grey
                                          : AppColors.primaryButton,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Spacer(),

                            if (cubit.remainingSeconds > 0) Text(displayTime),
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
