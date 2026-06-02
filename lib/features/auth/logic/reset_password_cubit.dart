import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/network/api_helper.dart';
import 'auth_state.dart';

class ResetPasswordInitial extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ResetPasswordError extends AuthState {
  final String message;

  ResetPasswordError(this.message);
}

class ResetPasswordCubit extends Cubit<AuthState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    emit(ResetPasswordInitial());
  }

  Future<void> resetPassword({
    required String countryCode,
    required String phoneNumber,
  }) async {
    if (newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      emit(ResetPasswordError("Please enter all fields"));
      return;
    }

    emit(ResetPasswordLoading());
    try {
      final response = await ApiHelper.dio.post(
        '/api/Auth/reset-password',
        data: {
          "countryCode": countryCode,
          "phoneNumber": phoneNumber,
          "newPassword": newPasswordController.text,
          "confirmPassword": confirmPasswordController.text,
        },
      );

      emit(ResetPasswordSuccess());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(ResetPasswordError("Connection timed out. Please try again."));
      } else if (e.response != null) {
        emit(
          ResetPasswordError(e.response?.data['message'] ?? "Unknown Error"),
        );
      }
    }
  }
}