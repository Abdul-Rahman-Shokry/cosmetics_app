import 'package:cosmetics_app/core/network/api_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/network/api_error_handler.dart';
import '../data/models/country_model.dart';
import 'dart:developer';
import 'auth_state.dart';

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final String token;
  final String username;
  final String profilePhoto;

  LoginSuccess(this.token, this.username, this.profilePhoto);
}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutError extends AuthState {
  final String message;

  LogoutError(this.message);
}

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(LoginInitial());

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  List<CountryModel> countries = [];
  CountryModel? selectedCountry;

  bool isPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    emit(LoginInitial());
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
      emit(LoginError("Failed to load countries"));
    }
  }

  Future<void> login() async {
    if (phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        selectedCountry == null) {
      emit(LoginError("Please enter all fields"));
      return;
    }

    emit(LoginLoading());
    try {
      final response = await ApiHelper.dio.post(
        '/api/Auth/login',
        data: {
          "countryCode": selectedCountry!.code,
          "phoneNumber": phoneController.text,
          "password": passwordController.text,
        },
      );

      final token = response.data['token'];

      final user = response.data['user'];
      final username = user['username'];
      final profilePhoto = user['profilePhotoUrl'] ?? "profile_pic.png";

      log("Token: $token");

      emit(LoginSuccess(token, username, profilePhoto));
    } catch (e) {
      emit(LoginError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> logout(String token) async {

    emit(LoginLoading());
    try {
      final response = await ApiHelper.dio.post(
        '/api/Auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError(ApiErrorHandler.getMessage(e)));
    }
  }
}
