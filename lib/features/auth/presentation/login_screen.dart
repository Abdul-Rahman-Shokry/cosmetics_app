import 'package:cosmetics_app/core/constants/app_colors.dart';
import 'package:cosmetics_app/core/widgets/auth_button.dart';
import 'package:cosmetics_app/features/auth/presentation/forget_password_screen.dart';
import 'package:cosmetics_app/features/auth/presentation/register_screen.dart';
import 'package:cosmetics_app/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../logic/auth_cubit.dart';
import '../../../core/utils/helper_method.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..getCountries(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Center(
              child: BlocConsumer<LoginCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginError) {
                    // if (state.message ==
                    //     "Account not verified. Please verify your phone number first.") {
                    //   goTo(page: VerifyCode(), canPop: true);
                  showMsg(state.message);

                  } else if (state is LoginSuccess) {
                    showMsg("Login successful!");
                    goTo(page: HomeScreen(), canPop: false);
                  }
                },

                builder: (context, state) {
                  final cubit = context.read<LoginCubit>();

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/login_img.png"),

                        const SizedBox(height: 25),

                        Text(
                          "Login Now",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),

                        const SizedBox(height: 14),

                        Text(
                          "Please enter the details below to continue",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 25),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 46.06,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.border,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  value: cubit.selectedCountry?.code,
                                  items: cubit.countries.map((country) {
                                    return DropdownMenuItem(
                                      value: country.code,
                                      child: Text(country.code),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      cubit.selectedCountry = cubit.countries
                                          .firstWhere((c) => c.code == value);

                                      cubit.emit(LoginInitial());
                                    }
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(width: 7.94),

                            Expanded(
                              child: SizedBox(
                                height: 46.06,
                                child: TextField(
                                  controller: cubit.phoneController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    labelText: "Phone Number",
                                    labelStyle: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                    counter: SizedBox.shrink(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        SizedBox(
                          height: 58,
                          child: TextField(
                            controller: cubit.passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: cubit.isPasswordObscured,
                            decoration: InputDecoration(
                              labelText: "Your Password",
                              labelStyle: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              counter: SizedBox.shrink(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  cubit.togglePasswordVisibility();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    cubit.isPasswordObscured
                                        ? 'assets/images/visibility.svg'
                                        : 'assets/images/visibility_off.svg',
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

                        const SizedBox(height: 11.94),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              goTo(page: ForgetPassword(), canPop: true);
                            },
                            child: Text(
                              "Forget Password?",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                    color: AppColors.primaryButton,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 43),

                        state is LoginLoading
                            ? const CircularProgressIndicator()
                            : SharedAuthButton(
                                text: "Login",
                                onPressed: () {
                                  cubit.login();
                                },
                              ),

                        const SizedBox(height: 85),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                            ),
                            GestureDetector(
                              onTap: () {
                                goTo(page: RegisterScreen(), canPop: true);
                              },
                              child: Text(
                                "Register",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: 12,
                                      color: AppColors.primaryButton,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
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
