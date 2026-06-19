class SliderModel {
  final int id;
  final String couponCode;
  final int discountPercent;
  final String descriptionTitle1En;
  final String descriptionTitle1Ar;
  final String descriptionTitle2En;
  final String descriptionTitle2Ar;
  final String imageUrl;

  SliderModel({
    required this.id,
    required this.couponCode,
    required this.discountPercent,
    required this.descriptionTitle1En,
    required this.descriptionTitle1Ar,
    required this.descriptionTitle2En,
    required this.descriptionTitle2Ar,
    required this.imageUrl,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      couponCode: json['coupon_code'] ?? '',
      discountPercent: json['discount_percent'] ?? 0,
      descriptionTitle1En: json['description_title1_en'] ?? '',
      descriptionTitle1Ar: json['description_title1_ar'] ?? '',
      descriptionTitle2En: json['description_title2_en'] ?? '',
      descriptionTitle2Ar: json['description_title2_ar'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}