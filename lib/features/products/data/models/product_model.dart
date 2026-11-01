
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double discountPrice;
  final double rating;
  final String imageUrl;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.rating,
    required this.imageUrl,
    List<String>? images,
  }) : images = images ?? [imageUrl];

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] as num).toDouble();
    final discountPercentage =
        (json['discountPercentage'] as num).toDouble();

    final imageUrl = json['thumbnail'] as String;

    final images = (json['images'] as List<dynamic>?)
            ?.map((image) => image.toString())
            .toList() ??
        [imageUrl];

    return ProductModel(
      id: json['id'].toString(),
      name: json['title'] as String,
      description: json['description'] as String,
      price: price,
      discountPrice: price * (1 - discountPercentage / 100),
      rating: (json['rating'] as num).toDouble(),
      imageUrl: imageUrl,
      images: images,
    );
  }
}
