import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class ApiHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        receiveDataWhenStatusError: true,
      ),
    );
  }
}