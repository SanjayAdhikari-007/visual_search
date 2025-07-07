import 'dart:convert';

import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required super.title,
      required super.detail,
      required super.id,
      required super.createdAt,
      required super.brandName,
      required super.images,
      required super.color,
      required super.category,
      required super.price,
      required super.discountRate,
      required super.priceAfterDiscount,
      required super.rating,
      required super.isInStock});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'detail': detail,
      'brandName': brandName,
      'images': images,
      'color': color,
      'category': category,
      'price': price,
      'discountRate': discountRate,
      'priceAfterDiscount': priceAfterDiscount,
      'rating': rating,
      'isInStock': isInStock,
      'createdAt': createdAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      title: map['title'] as String,
      detail: map['detail'] as String,
      brandName: map['brandName'] as String,
      images: List<String>.from((map['images'] as List<dynamic>)),
      color: map['color'] as String,
      category: map['category'] as String,
      price: double.parse(map['price'].toString()),
      discountRate: double.parse(map['discountRate'].toString()),
      priceAfterDiscount: double.parse(map['priceAfterDiscount'].toString()),
      rating: double.parse(map['rating'].toString()),
      isInStock: map['isInStock'] as bool,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id , title: $title, detail: $detail, brandName:$brandName, images: $images, category: $category ,color: $color, price: $price, discountRate: $discountRate, priceAfterDiscount: $priceAfterDiscount, rating: $rating, isInStock: $isInStock, createdAt: $createdAt)';
  }
}
