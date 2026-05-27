class CountryModel {
  final int id;
  final String code;
  final String nameEn;
  final String nameAr;

  CountryModel({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameAr,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      code: json['code'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
    );
  }
}