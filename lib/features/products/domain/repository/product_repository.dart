import '../../data/models/product_model.dart';

abstract interface class ProductRepository {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getFeatured();
  Future<List<ProductModel>> getPopular();
  Future<List<ProductModel>> getPerCategory();
  Future<List<ProductModel>> getTwoPerCategory();
  Future<List<ProductModel>> getAllProductsByCategory(String categoryId);
  Future<ProductModel> getSingleProduct(String id);
  Future<List<ProductModel>> visualSearchById(String categoryId, String color);
  Future<List<ProductModel>> visualSearchByName(
      String categoryName, String color);
  Future<List<ProductModel>> visualSearchByCategory(String categoryName);
  Future<List<ProductModel>> visualSearchByCategoryAndPattern(
      String categoryName, String pattern);
  Future<List<ProductModel>> visualSearchByCategoryAndPatternAndColor(
      String categoryName, String pattern, String color);
}
