import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/api_helper.dart';
import '../data/models/country_model.dart';
import 'dart:developer';
import 'auth_state.dart';

class RegisterInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterStepOneSuccess extends AuthState {
  final String token;

  RegisterStepOneSuccess({required this.token});
}

class RegisterStepTwoSuccess extends AuthState {}

class RegisterError extends AuthState {
  final String message;

  RegisterError(this.message);
}

class RegisterCubit extends Cubit<AuthState> {
  RegisterCubit() : super(RegisterInitial());

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final createPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  List<CountryModel> countries = [];
  CountryModel? selectedCountry;

  bool isPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    emit(RegisterInitial());
  }

  Future<void> getCountries() async {
    emit(CountriesLoading());
    try {
      final response = await ApiHelper.dio.get('/api/Countries');
      final List data = response.data;
      countries = data.map((e) => CountryModel.fromJson(e)).toList();

      if (countries.isNotEmpty) {
        selectedCountry = countries.first;
      }
      emit(CountriesSuccess());
    } catch (e) {
      emit(RegisterError("Failed to load countries"));
    }
  }

  Future<void> register() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        createPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        selectedCountry == null) {
      emit(RegisterError("Please enter all fields"));
      return;
    }

    if (createPasswordController.text != confirmPasswordController.text) {
      emit(RegisterError("Passwords don't match"));
      return;
    }

    emit(RegisterLoading());
    try {
      final response = await ApiHelper.dio.post(
        '/api/Auth/register',
        data: {
          "username": usernameController.text,
          "countryCode": selectedCountry!.code,
          "phoneNumber": phoneController.text,
          "email": emailController.text,
          "password": confirmPasswordController.text,
        },
      );

      final message = response.data['message'];

      log("Token: $message");

      emit(RegisterStepOneSuccess(token: message));
    } catch (e) {
      emit(RegisterError(ApiErrorHandler.getMessage(e)));
    }
  }
}