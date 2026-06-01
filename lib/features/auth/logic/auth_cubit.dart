import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data/models/country_model.dart';
import 'dart:developer';
import 'dart:async';

abstract class AuthState {}

// Login states
class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

// Register states
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

// Verify code states
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

// Forget Password states
class ForgetPasswordInitial extends AuthState {}

class ForgetPasswordLoading extends AuthState {}

class ForgetPasswordSuccess extends AuthState {}

class ForgetPasswordError extends AuthState {
  final String message;

  ForgetPasswordError(this.message);
}

// Reset password states
class ResetPasswordInitial extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ResetPasswordError extends AuthState {
  final String message;

  ResetPasswordError(this.message);
}

// Shared states
class CountriesLoading extends AuthState {}

class CountriesSuccess extends AuthState {}

class LoginCubit extends Cubit<AuthState> {
  /*
  * TODO: Handle this in login
  * {
  *  "message": "Account not verified. Please verify your phone number first."
  *  }
  * */

  LoginCubit() : super(LoginInitial());

  final Dio dio = Dio(BaseOptions(baseUrl: "https://cosmatics.growfet.com"));

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

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

class RegisterCubit extends Cubit<AuthState> {
  RegisterCubit() : super(RegisterInitial());

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://cosmatics.growfet.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

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
      final response = await dio.get('/api/Countries');
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
      final response = await dio.post(
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
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(RegisterError("Connection timed out. Please try again."));
      } else if (e.response != null) {
        emit(RegisterError(e.response?.data['message'] ?? "Unknown Error"));
      }
    }
  }
}

class VerifyCodeCubit extends Cubit<AuthState> {
  VerifyCodeCubit() : super(VerifyCodeInitial());

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://cosmatics.growfet.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

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
      final response = await dio.post(
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
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(VerifyCodeError("Connection timed out. Please try again."));
      } else if (e.response != null) {
        emit(VerifyCodeError(e.response?.data['message'] ?? "Unknown Error"));
      }
    } catch (e) {
      emit(VerifyCodeError(e.toString()));
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
      final response = await dio.post(
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
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        emit(ResendOTPError("Connection timed out. Please try again."));
      } else if (e.response != null) {
        emit(ResendOTPError(e.response?.data['message'] ?? "Unknown Error"));
      }
    } catch (e) {
      emit(ResendOTPError(e.toString()));
    }
  }
}

class ForgetPasswordCubit extends Cubit<AuthState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final Dio dio = Dio(
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

class ResetPasswordCubit extends Cubit<AuthState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://cosmatics.growfet.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    emit(RegisterInitial());
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
      final response = await dio.post(
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
