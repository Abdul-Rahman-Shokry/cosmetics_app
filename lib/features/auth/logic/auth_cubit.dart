import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data/models/country_model.dart';

abstract class AuthState {}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

class CountriesLoading extends AuthState {}

class CountriesSuccess extends AuthState {}

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(LoginInitial());

  final Dio dio = Dio(BaseOptions(baseUrl: "https://cosmatics.growfet.com"));

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  List<CountryModel> countries = [];
  CountryModel? selectedCountry;

  Future<void> getCountries() async {
    emit(CountriesLoading());
    try {
      final response = await dio.get('/api/Countries');
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
      final response = await dio.post(
        '/api/Auth/login',
        data: {
          "countryCode": selectedCountry!.code,
          "phoneNumber": phoneController.text,
          "password": passwordController.text,
        },
      );

      final token = response.data['token'];
      print("Token: $token");

      emit(LoginSuccess());
    } on DioException {
      emit(LoginError("Invalid login credentials"));
    }
  }
}
