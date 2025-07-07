import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_search/features/discover/domain/repository/category_repository.dart';

import '../../data/models/category_model.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  List<CategoryModel> categories = [];
  final CategoryRepository repository;
  DiscoverCubit(this.repository) : super(DiscoverInitial());

  void getAllCategories() async {
    final results = await repository.getAllCategories();
    categories = results;
    emit(DiscoverData(results));
  }

  void getSingleCategory(String id) async {
    final results = await repository.getSingleCategory(id);
    emit(DiscoverSingleData(results));
  }

  void getCategoryByName(String name) async {
    final results = await repository.getCategoryByName(name);
    emit(DiscoverSingleData(results));
  }

  CategoryModel categoryFromId(String id) {
    try {
      final cat = categories.firstWhere((element) => element.id == id);
      return cat;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
