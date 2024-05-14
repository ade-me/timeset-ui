class Country {
  final String name;
  final String code;
  final String image;
  final String dialCode;

  const Country({
    required this.code,
    required this.name,
    required this.image,
    required this.dialCode,
  });

  factory Country.fromJSon({required Map<String, dynamic> json}) {
    return Country(
      code: json['code'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      dialCode: json['dial_code'] as String,
    );
  }

  String imageUrl() {
    String imageUrl = 'https://country-code-au6g.vercel.app/$image';

    return imageUrl;
  }
}
