class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double discountPrice;
  final double rating;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.rating,
    required this.imageUrl,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
  final price = (json['price'] as num).toDouble();
  final discountPercentage =
      (json['discountPercentage'] as num).toDouble();

  return ProductModel(
    id: json['id'].toString(),
    name: json['title'] as String,
    description: json['description'] as String,
    price: price,
    discountPrice: price * (1 - discountPercentage / 100),
    rating: (json['rating'] as num).toDouble(),
    imageUrl: json['thumbnail'] as String,
  );
}
}
