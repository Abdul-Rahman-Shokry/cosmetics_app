import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:async';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/api_helper.dart';
import 'auth_state.dart';

class VerifyCodeInitial extends AuthState {}

class VerifyCodeLoading extends AuthState {}

class VerifyCodeSuccess extends AuthState {}

class VerifyCodeError extends AuthState {
  final String message;

  VerifyCodeError(this.message);
}

class ResendOTPLoading extends AuthState {}

class ResendOTPSuccess extends AuthState {
  final String message;

  ResendOTPSuccess(this.message);
}

class ResendOTPError extends AuthState {
  final String message;

  ResendOTPError(this.message);
}

class ResendOTPTimerUpdate extends AuthState {
  final int remainingSeconds;

  ResendOTPTimerUpdate(this.remainingSeconds);
}

class VerifyCodeCubit extends Cubit<AuthState> {
  VerifyCodeCubit() : super(VerifyCodeInitial());

  final otpController = TextEditingController();

  Timer? _timer;
  int remainingSeconds = 0;

  void startTimer() {
    remainingSeconds = 30;
    emit(ResendOTPTimerUpdate(remainingSeconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        emit(ResendOTPTimerUpdate(remainingSeconds));
      } else {
        _timer?.cancel();
        emit(VerifyCodeInitial());
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> verifyCode({
    required String countryCode,
    required String phoneNumber,
    String? token,
  }) async {
    final code = otpController.text;

    if (code.length != 4) {
      emit(VerifyCodeError("Please enter the full code"));
      return;
    }

    emit(VerifyCodeLoading());

    try {
      final response = await ApiHelper.dio.post(
        '/api/Auth/verify-otp',
        data: {
          "countryCode": countryCode,
          "phoneNumber": phoneNumber,
          "otpCode": code,
        },
        options: token != null
            ? Options(headers: {"Authorization": "Bearer $token"})
            : null,
      );

      final message = response.data['message'];
      log(message.toString());

      emit(VerifyCodeSuccess());

    } catch (e) {
      emit(VerifyCodeError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> resendOTP({
    required String countryCode,
    required String phoneNumber,
    String? token,
  }) async {
    if (remainingSeconds > 0) return;

    emit(ResendOTPLoading());

    try {
      final response = await ApiHelper.dio.post(
        '/api/Auth/resend-otp',
        data: {"countryCode": countryCode, "phoneNumber": phoneNumber},
        options: token != null
            ? Options(headers: {"Authorization": "Bearer $token"})
            : null,
      );

      final message = response.data['message'];
      log(message.toString());

      otpController.clear();

      emit(ResendOTPSuccess(message));

      startTimer();

    } catch (e) {
      emit(ResendOTPError(ApiErrorHandler.getMessage(e)));
    }
  }
}