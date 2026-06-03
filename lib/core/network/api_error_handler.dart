import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String getMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return "Connection timed out. Please try again.";
        case DioExceptionType.connectionError:
          return "No Internet Connection. Please check your network.";
        case DioExceptionType.badResponse:
          if (error.response?.data != null && error.response?.data is Map) {
            return error.response?.data['message'] ?? "Unknown Server Error";
          }
          return "Server error occurred.";
        case DioExceptionType.cancel:
          return "Request was cancelled.";
        default:
          return "An unexpected network error occurred.";
      }
    }
    return "Unexpected error: ${error.toString()}";
  }
}
