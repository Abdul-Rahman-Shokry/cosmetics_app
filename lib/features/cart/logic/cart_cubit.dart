import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/network/api_error_handler.dart';
import '../../../../core/network/api_helper.dart';
import '../data/models/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final _secureStorage = const FlutterSecureStorage();

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      final token = await _secureStorage.read(key: 'token');
      final response = await ApiHelper.dio.get(
        '/api/Cart',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final cart = CartModel.fromJson(response.data);
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> updateCartItem(int productId, int quantity) async {
    if (quantity < 1) {
      await removeFromCart(productId);
      return;
    }

    try {
      final token = await _secureStorage.read(key: 'token');
      final response = await ApiHelper.dio.put(
        '/api/Cart/update',
        queryParameters: {
          'productId': productId,
          'quantity': quantity,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final cart = CartModel.fromJson(response.data);
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(ApiErrorHandler.getMessage(e)));
    }
  }

  Future<void> removeFromCart(int productId) async {
    try {
      final token = await _secureStorage.read(key: 'token');
      final response = await ApiHelper.dio.delete(
        '/api/Cart/remove/$productId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final cart = CartModel.fromJson(response.data);
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(ApiErrorHandler.getMessage(e)));
    }
  }
}