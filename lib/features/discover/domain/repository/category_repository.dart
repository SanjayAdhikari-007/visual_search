import '../../data/models/category_model.dart';

abstract interface class CategoryRepository {
  Future<List<CategoryModel>> getAllCategories();
  Future<CategoryModel> getSingleCategory(String id);
  Future<CategoryModel> getCategoryByName(String name);
}
