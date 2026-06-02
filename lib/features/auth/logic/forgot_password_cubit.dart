import 'package:cosmetics_app/core/network/api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data/models/country_model.dart';
import 'auth_state.dart';

class ForgotPasswordInitial extends AuthState {}

class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {}

class ForgotPasswordError extends AuthState {
  final String message;

  ForgotPasswordError(this.message);
}

class ForgotPasswordCubit extends Cubit<AuthState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  final phoneController = TextEditingController();

  List<CountryModel> countries = [];
  CountryModel? selectedCountry;

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
      emit(ForgotPasswordError("Failed to load countries"));
    }
  }

  Future<void> ForgotPassword() async {
    if (phoneController.text.isEmpty || selectedCountry == null) {
      emit(ForgotPasswordError("Please enter all fields"));
      return;
    }

    emit(ForgotPasswordLoading());
    try {
      final response = await ApiHelper.dio.post(
        '/api/Auth/forgot-password',
        data: {
          "countryCode": selectedCountry!.code,
          "phoneNumber": phoneController.text,
        },
      );

      emit(ForgotPasswordSuccess());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(ForgotPasswordError("Connection timed out. Please try again."));
      } else if (e.response != null) {
        emit(
          ForgotPasswordError(e.response?.data['message'] ?? "Unknown Error"),
        );
      }
    }
  }
}