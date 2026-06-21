class CartItemModel {
  final int productId;
  final String productNameEn;
  final String productNameAr;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItemModel({
    required this.productId,
    required this.productNameEn,
    required this.productNameAr,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'],
      productNameEn: json['product_name_en'] ?? '',
      productNameAr: json['product_name_ar'] ?? '',
      quantity: json['quantity'] ?? 1,
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['image_url'] ?? '',
    );
  }
}