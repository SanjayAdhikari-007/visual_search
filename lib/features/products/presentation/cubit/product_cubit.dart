import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_search/features/products/domain/repository/product_repository.dart';

import '../../data/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  List<ProductModel> extraProducts = [];
  List<ProductModel> featured = [];
  List<ProductModel> popularProducts = [];
  final ProductRepository repository;
  ProductCubit(this.repository) : super(ProductInitial());

  // void getAllProducts() async {
  //   emit(ProductLoading());
  //   if (popProducts.isEmpty) {
  //     final List<ProductModel> results = await repository.getAllProducts();
  //     popProducts = results.getRange(0, 8).toList();
  //     extraProducts = results.getRange(8, results.length - 1).toList();
  //   }
  //   emit(ProductData(popProducts));
  // }

  void getProducts() async {
    emit(ProductLoading());
    if (popularProducts.isEmpty) {
      featured = await repository.getFeatured();
      final List<ProductModel> results = await repository.getAllProducts();
      popularProducts = results.getRange(0, 8).toList();
    }
    emit(ProductData(popularProducts));
  }

  void getAllProductsByCategory(String categoryId) async {
    emit(ProductLoading());
    final List<ProductModel> results =
        await repository.getAllProductsByCategory(categoryId);
    emit(ProductData(results));
  }

  void getSingleProduct(String id) async {
    emit(ProductLoading());
    final ProductModel result = await repository.getSingleProduct(id);
    emit(ProductSingleData(result));
  }

  void visualSearchById(String categoryId, String color) async {
    emit(ProductLoading());
    final List<ProductModel> results =
        await repository.visualSearchById(categoryId, color);
    emit(ProductData(results));
  }

  void visualSearchByName(String categoryName, String color) async {
    emit(ProductLoading());
    final List<ProductModel> results =
        await repository.visualSearchByName(categoryName, color);
    Future.delayed(
      Duration(milliseconds: 350),
      () {
        emit(ProductVisualData(results));
      },
    );
  }

  void visualSearchByCategoryAndPattern(
      String categoryName, String pattern) async {
    emit(ProductLoading());
    final List<ProductModel> results = await repository
        .visualSearchByCategoryAndPattern(categoryName, pattern);
    Future.delayed(
      Duration(milliseconds: 350),
      () {
        emit(ProductVisualData(results));
      },
    );
  }
}
