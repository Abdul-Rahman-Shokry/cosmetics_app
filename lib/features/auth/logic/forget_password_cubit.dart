import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data/models/country_model.dart';
import 'auth_state.dart';

class ForgetPasswordInitial extends AuthState {}

class ForgetPasswordLoading extends AuthState {}

class ForgetPasswordSuccess extends AuthState {}

class ForgetPasswordError extends AuthState {
  final String message;

  ForgetPasswordError(this.message);
}

class ForgetPasswordCubit extends Cubit<AuthState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final dio = Dio(
    BaseOptions(
      baseUrl: "https://cosmatics.growfet.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  final phoneController = TextEditingController();

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
      emit(ForgetPasswordError("Failed to load countries"));
    }
  }

  Future<void> forgetPassword() async {
    if (phoneController.text.isEmpty || selectedCountry == null) {
      emit(ForgetPasswordError("Please enter all fields"));
      return;
    }

    emit(ForgetPasswordLoading());
    try {
      final response = await dio.post(
        '/api/Auth/forgot-password',
        data: {
          "countryCode": selectedCountry!.code,
          "phoneNumber": phoneController.text,
        },
      );

      emit(ForgetPasswordSuccess());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(ForgetPasswordError("Connection timed out. Please try again."));
      } else if (e.response != null) {
        emit(
          ForgetPasswordError(e.response?.data['message'] ?? "Unknown Error"),
        );
      }
    }
  }
}