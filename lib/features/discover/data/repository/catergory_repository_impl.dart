import 'package:flutter/material.dart';
import 'package:visual_search/features/discover/data/datasource/category_data_source.dart';

import '../../domain/repository/category_repository.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource source;

  CategoryRepositoryImpl(this.source);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final list = await source.getAllCategories();
      return list;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<CategoryModel> getCategoryByName(String name) async {
    try {
      final result = await source.getCategoryByName(name);
      return result;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<CategoryModel> getSingleCategory(String id) async {
    try {
      final result = await source.getSingleCategory(id);
      return result;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
