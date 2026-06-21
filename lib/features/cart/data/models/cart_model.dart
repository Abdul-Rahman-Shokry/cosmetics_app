import 'cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;
  final double total;

  CartModel({
    required this.items,
    required this.total,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List).map((e) => CartItemModel.fromJson(e)).toList(),
      total: (json['total'] ?? 0).toDouble(),
    );
  }
}