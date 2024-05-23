class Product {
  final String imageUrl;
  final String title;
  final String description;
  final double ratings;
  final double price;
  final double discount;
  final String userId;

  const Product({
    required this.price,
    required this.title,
    required this.userId,
    required this.ratings,
    required this.imageUrl,
    required this.discount,
    required this.description,
  });
}
