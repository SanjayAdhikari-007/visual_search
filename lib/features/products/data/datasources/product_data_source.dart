import 'dart:convert';

import 'package:visual_search/core/db/local_db.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

abstract interface class ProductDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getPerCategory();
  Future<List<ProductModel>> getAllProductsByCategory(String categoryId);
  Future<ProductModel> getSingleProduct(String id);
  Future<List<ProductModel>> visualSearchById(String categoryId, String color);
  Future<List<ProductModel>> visualSearchByName(
      String categoryName, String color);
}

class ProductDataSourceImpl implements ProductDataSource {
  @override
  Future<List<ProductModel>> getAllProducts() async {
    var client = http.Client();
    String? token = await LocalDb().getToken();
    var response = await client
        .get(Uri.parse("${Constants.baseApiUrl}/products"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 500) {
      throw ServerException(
          (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
    }

    var arr = jsonDecode(response.body) as List<dynamic>;

    List<ProductModel> results = [];

    for (Map<String, dynamic> product in arr) {
      ProductModel model = ProductModel.fromJson(jsonEncode(product));
      results.add(model);
    }

    return results;
  }

  @override
  Future<List<ProductModel>> getPerCategory() async {
    var client = http.Client();
    String? token = await LocalDb().getToken();
    var response = await client.get(
        Uri.parse("${Constants.baseApiUrl}/products/percategory"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 500) {
      throw ServerException(
          (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
    }

    var arr = jsonDecode(response.body) as List<dynamic>;
    List<ProductModel> results = [];

    for (Map<String, dynamic> product in arr) {
      ProductModel model = ProductModel.fromJson(jsonEncode(product));
      results.add(model);
    }

    return results;
  }

  @override
  Future<ProductModel> getSingleProduct(String id) async {
    var client = http.Client();
    String? token = await LocalDb().getToken();
    var response = await client
        .get(Uri.parse("${Constants.baseApiUrl}/products/$id"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 500) {
      throw ServerException(
          (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
    }
    ProductModel model = ProductModel.fromJson(response.body);
    return model;
  }

  @override
  Future<List<ProductModel>> getAllProductsByCategory(String categoryId) async {
    var client = http.Client();
    String? token = await LocalDb().getToken();
    var response = await client.get(
        Uri.parse("${Constants.baseApiUrl}/products/category/$categoryId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 500) {
      throw ServerException(
          (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
    }

    var arr = jsonDecode(response.body) as List<dynamic>;

    List<ProductModel> results = [];

    for (Map<String, dynamic> product in arr) {
      print(product);
      print("\n");
      ProductModel model = ProductModel.fromJson(jsonEncode(product));
      results.add(model);
    }

    return results;
  }

  @override
  Future<List<ProductModel>> visualSearchById(
      String categoryId, String color) async {
    var client = http.Client();
    String? token = await LocalDb().getToken();
    var response = await client.get(
        Uri.parse(
            "${Constants.baseApiUrl}/products/vs/$categoryId?color=$color"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 500) {
      throw ServerException(
          (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
    }

    var arr = jsonDecode(response.body) as List<dynamic>;

    List<ProductModel> results = [];

    for (Map<String, dynamic> product in arr) {
      ProductModel model = ProductModel.fromJson(jsonEncode(product));
      results.add(model);
    }

    return results;
  }

  @override
  Future<List<ProductModel>> visualSearchByName(
    String categoryName,
    String color,
  ) async {
    var client = http.Client();
    String? token = await LocalDb().getToken();
    var response = await client.get(
        Uri.parse(
            "${Constants.baseApiUrl}/products/visual_search/$categoryName?color=$color"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 500) {
      throw ServerException(
          (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
    }

    var arr = jsonDecode(response.body) as List<dynamic>;

    List<ProductModel> results = [];

    for (Map<String, dynamic> product in arr) {
      ProductModel model = ProductModel.fromJson(jsonEncode(product));
      results.add(model);
    }

    return results;
  }
}
