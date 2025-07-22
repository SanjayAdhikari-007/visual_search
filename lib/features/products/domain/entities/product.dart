class Product {
  final String id;
  final String title;
  final String detail;
  final String brandName;
  final List<String> images;
  final String color;
  final String pattern;
  final String category;
  final double price;
  final double discountRate;
  final double priceAfterDiscount;
  final double rating;
  final bool isInStock;
  final bool isFeatured;
  final bool isPopular;
  final String createdAt;

  Product({
    required this.title,
    required this.detail,
    required this.id,
    required this.createdAt,
    required this.brandName,
    required this.images,
    required this.color,
    required this.pattern,
    required this.category,
    required this.price,
    required this.discountRate,
    required this.priceAfterDiscount,
    required this.rating,
    required this.isInStock,
    required this.isFeatured,
    required this.isPopular,
  });
}
