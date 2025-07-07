import '../../data/models/product_model.dart';

abstract interface class ProductRepository {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getPerCategory();
  Future<List<ProductModel>> getAllProductsByCategory(String categoryId);
  Future<ProductModel> getSingleProduct(String id);
  Future<List<ProductModel>> visualSearchById(String categoryId, String color);
  Future<List<ProductModel>> visualSearchByName(
      String categoryName, String color);
}
