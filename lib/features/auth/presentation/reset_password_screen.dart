import 'package:cosmetics_app/core/utils/helper_methods.dart';
import 'package:cosmetics_app/core/widgets/app_image.dart';
import 'package:cosmetics_app/core/widgets/success_dialog.dart';
import 'package:cosmetics_app/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/auth_state.dart';
import '../logic/reset_password_cubit.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/auth_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String countryCode;
  final String phoneNumber;

  const ResetPasswordScreen({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Center(
              child: BlocConsumer<ResetPasswordCubit, AuthState>(
                listener: (context, state) {
                  if (state is ResetPasswordError) {
                    showMsg(state.message);
                  }
                  else if (state is ResetPasswordSuccess) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return SuccessDialog(
                              title: "Password Created!",
                              message: "Congratulations! Your password has been successfully created",
                              buttonText: "Return to login",
                              onPressed: (){
                                Navigator.pop(context);
                                goTo(page: LoginScreen(), canPop: false);
                              }
                          );
                        }
                    );
                    // goTo(page: LoginScreen(), canPop: false);
                  }
                },

                builder: (context, state) {
                  final cubit = context.read<ResetPasswordCubit>();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppImage("Layer_1_67_x_62.png"),

                      const SizedBox(height: 40),

                      Text(
                        "Forget Password",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: 300,
                        child: Text(
                          "Please enter your phone number below to recovery your password.",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 45),

                      // Create your password
                      SizedBox(
                        height: 58,
                        child: TextField(
                          controller: cubit.newPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: cubit.isPasswordObscured,
                          decoration: InputDecoration(
                            labelText: "Create your password",
                            labelStyle: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                            counter: SizedBox.shrink(),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                cubit.togglePasswordVisibility();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppImage(
                                  cubit.isPasswordObscured
                                      ? 'visibility.svg'
                                      : 'visibility_off.svg',
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.border,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.border,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Confirm password
                      SizedBox(
                        height: 58,
                        child: TextField(
                          controller: cubit.confirmPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: cubit.isPasswordObscured,
                          decoration: InputDecoration(
                            labelText: "Confirm password",
                            labelStyle: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                            counter: SizedBox.shrink(),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                cubit.togglePasswordVisibility();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppImage(
                                  cubit.isPasswordObscured
                                      ? 'visibility.svg'
                                      : 'visibility_off.svg',
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.border,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.border,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 55.94),

                      SharedAuthButton(
                        text: "Next",
                        onPressed: () {
                          cubit.resetPassword(
                            countryCode: countryCode,
                            phoneNumber: phoneNumber,
                          );
                        },
                      ),
                    ],
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
