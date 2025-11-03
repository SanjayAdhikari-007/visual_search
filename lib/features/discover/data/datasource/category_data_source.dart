import 'dart:convert';

import 'package:visual_search/core/db/local_db.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/category_model.dart';
import 'package:http/http.dart' as http;

abstract interface class CategoryDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<CategoryModel> getSingleCategory(String id);
  Future<CategoryModel> getCategoryByName(String name);
}

class CategoryDataSourceImpl implements CategoryDataSource {
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    var client = http.Client();
    return await LocalDb().getToken().then((val) async {
      var response = await client
          .get(Uri.parse("${Constants.baseApiUrl}/categories"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $val',
      });

      if (response.statusCode == 404 ||
          response.statusCode == 401 ||
          response.statusCode == 500) {
        throw ServerException(
            (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
      }

      var arr = jsonDecode(response.body) as List<dynamic>;

      List<CategoryModel> results = [];

      for (Map<String, dynamic> product in arr) {
        CategoryModel model = CategoryModel.fromJson(jsonEncode(product));
        results.add(model);
      }

      return results;
    });
    // String? token = await LocalDb().getToken();
    // var response = await client
    //     .get(Uri.parse("${Constants.baseApiUrl}/categories"), headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token',
    // });
    // printM(response.statusCode.toString());
    // printR(response.body);

    // if (response.statusCode == 404 ||
    //     response.statusCode == 401 ||
    //     response.statusCode == 500) {
    //   throw ServerException(
    //       (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
    // }

    // var arr = jsonDecode(response.body) as List<dynamic>;

    // List<CategoryModel> results = [];

    // for (Map<String, dynamic> cat in arr) {
    //   CategoryModel model = CategoryModel.fromJson(jsonEncode(cat));
    //   results.add(model);
    // }

    // return results;
  }

  @override
  Future<CategoryModel> getCategoryByName(String name) async {
    var client = http.Client();
    String? token = await LocalDb().getToken();
    var response = await client.get(
        Uri.parse("${Constants.baseApiUrl}/categories/name/$name"),
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
    CategoryModel model = CategoryModel.fromJson(response.body);
    return model;
  }

  @override
  Future<CategoryModel> getSingleCategory(String id) async {
    var client = http.Client();
    String? token = await LocalDb().getToken();
    var response = await client
        .get(Uri.parse("${Constants.baseApiUrl}/categories/$id"), headers: {
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
    CategoryModel model = CategoryModel.fromJson(response.body);
    return model;
  }
}
