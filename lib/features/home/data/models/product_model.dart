class ProductModel {
  final int id;
  final String nameEn;
  final String nameAr;
  final double price;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.price,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      nameEn: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['image_url'] ?? '',
    );
  }
}