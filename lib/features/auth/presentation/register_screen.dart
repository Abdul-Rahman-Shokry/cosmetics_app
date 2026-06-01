import 'package:cosmetics_app/features/auth/presentation/login_screen.dart';
import 'package:cosmetics_app/features/auth/presentation/verify_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helper_method.dart';
import '../../../core/widgets/auth_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/auth_state.dart';
import '../logic/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit()..getCountries(),

      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Center(
              child: BlocConsumer<RegisterCubit, AuthState>(
                listener: (context, state) {
                  if (state is RegisterError) {
                    showMsg(state.message);

                  } else if (state is RegisterStepOneSuccess) {
                    showMsg("Register successful!");

                    final cubit = context.read<RegisterCubit>();

                    goTo(
                      page: VerifyCode(
                        countryCode: cubit.selectedCountry!.code,
                        phoneNumber: cubit.phoneController.text,
                        email: cubit.emailController.text,
                        token: state.token,
                      ),
                      canPop: true,
                    );
                  }
                },

                builder: (context, state) {
                  final cubit = context.read<RegisterCubit>();

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Layer_1_67_x_62.png"),

                        const SizedBox(height: 40),

                        Text(
                          "Create Account",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),

                        const SizedBox(height: 71.94),

                        SizedBox(
                          height: 58,
                          child: TextField(
                            controller: cubit.usernameController,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "Your Name",
                              labelStyle: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              counter: SizedBox.shrink(),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
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

                        const SizedBox(height: 37.94),

                        // Email
                        SizedBox(
                          height: 58,
                          child: TextField(
                            controller: cubit.emailController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              counter: SizedBox.shrink(),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
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

                        const SizedBox(height: 33),

                        // Countries dropdown menu + Phone number
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 46.06,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
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

                                      cubit.emit(RegisterInitial());
                                    }
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(width: 4.85),

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

                        // Create your password
                        SizedBox(
                          height: 58,
                          child: TextField(
                            controller: cubit.createPasswordController,
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
                                onTap: (){
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
                                onTap: (){
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

                        const SizedBox(height: 16.82),

                        // Next button
                        state is RegisterLoading
                        ? const CircularProgressIndicator()
                        : SharedAuthButton(
                          text: "Next",
                          onPressed: () {
                            cubit.register();
                          },
                        ),

                        const SizedBox(height: 85),

                        // Have an account? Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have an account? ",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                            ),
                            GestureDetector(
                              onTap: () {
                                goTo(page: LoginScreen(), canPop: true);
                              },
                              child: Text(
                                "Login",
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
