import 'package:flutter/material.dart';
import '../../domain/repository/product_repository.dart';
import '../datasources/product_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource source;

  ProductRepositoryImpl(this.source);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final list = await source.getAllProducts();
      return list;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getTwoPerCategory() async {
    try {
      final list = await source.getTwoPerCategory();
      return list;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getPerCategory() async {
    try {
      final list = await source.getPerCategory();
      return list;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<ProductModel> getSingleProduct(String id) async {
    try {
      final result = await source.getSingleProduct(id);
      return result;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getAllProductsByCategory(String categoryId) async {
    try {
      final list = await source.getAllProductsByCategory(categoryId);
      return list;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> visualSearchById(
      String categoryId, String color) async {
    try {
      final list = await source.visualSearchById(categoryId, color);
      return list;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> visualSearchByName(
    String categoryName,
    String color,
  ) async {
    try {
      final list = await source.visualSearchByName(categoryName, color);
      return list;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> visualSearchByCategory(String categoryName) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> visualSearchByCategoryAndPattern(
      String categoryName, String pattern) async {
    try {
      final list =
          await source.visualSearchByCategoryAndPattern(categoryName, pattern);
      return list;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> visualSearchByCategoryAndPatternAndColor(
      String categoryName, String pattern, String color) async {
    try {
      final list = await source.visualSearchByCategoryAndPatternAndColor(
          categoryName, pattern, color);
      return list;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getFeatured() async {
    try {
      final list = await source.getFeatured();
      return list;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getPopular() async {
    try {
      final list = await source.getPopular();
      return list;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
