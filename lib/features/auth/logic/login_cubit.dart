import 'package:cosmetics_app/core/network/api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data/models/country_model.dart';
import 'dart:developer';
import 'auth_state.dart';

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
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
      log("Token: $token");

      emit(LoginSuccess());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(LoginError("Connection timed out. Please try again."));
      } else if (e.response != null) {
        emit(LoginError(e.response?.data['message'] ?? "Unknown Error"));
      }
    }
  }
}