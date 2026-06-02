import 'package:cosmetics_app/core/utils/helper_method.dart';
import 'package:cosmetics_app/features/auth/presentation/verify_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/auth_button.dart';
import '../logic/auth_state.dart';
import '../logic/forget_password_cubit.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit()..getCountries(),

      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Center(
              child: BlocConsumer<ForgetPasswordCubit, AuthState>(
                listener: (context, state) {
                  if(state is ForgetPasswordError){
                    showMsg(state.message);
                  }

                  else if (state is ForgetPasswordSuccess){
                    final cubit = context.read<ForgetPasswordCubit>();
                    goTo(page: VerifyCode(
                      countryCode: cubit.selectedCountry!.code,
                      phoneNumber: cubit.phoneController.text,
                      isForgetPasswordFlow: true,
                    ), canPop: true);
                  }

                },

                builder: (context, state) {
                  final cubit = context.read<ForgetPasswordCubit>();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/Layer_1_67_x_62.png"),

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

                                    cubit.emit(ForgetPasswordInitial());
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

                      const SizedBox(height: 55.94),

                      SharedAuthButton(
                          text: "Next",
                          onPressed: () {
                            cubit.forgetPassword();
                          }
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
