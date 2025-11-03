import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/db/local_db.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
  Future<void> logOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      var client = http.Client();
      final response = await client.post(
          Uri.parse("${Constants.baseApiUrl}/auth/login"),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8'
          },
          body: jsonEncode({"email": email, "password": password}));

      if (response.statusCode == 404 ||
          response.statusCode == 401 ||
          response.statusCode == 500) {
        throw ServerException(
            (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
      }

      UserModel user = UserModel.fromJson(
          (jsonDecode(response.body) as Map<String, dynamic>)["user"]);
      String token =
          (jsonDecode(response.body) as Map<String, dynamic>)["token"];

      LocalDb db = LocalDb();
      await db.saveUser(user, token);
      return user;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var client = http.Client();
      final response = await client.post(
          Uri.parse("${Constants.baseApiUrl}/auth/register"),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8'
          },
          body:
              jsonEncode({"email": email, "password": password, "name": name}));

      if (response.statusCode == 404 ||
          response.statusCode == 401 ||
          response.statusCode == 500) {
        throw ServerException(
            (jsonDecode(response.body) as Map<String, dynamic>)["message"]);
      }
      if (response.statusCode == 400) {
        var res = (jsonDecode(response.body) as Map<String, dynamic>);
        // ignore: prefer_interpolation_to_compose_strings
        throw ServerException(res["message"] + " " + res["error"]);
      }

      UserModel user = UserModel.fromJson(
          (jsonDecode(response.body) as Map<String, dynamic>)["user"]);

      await loginWithEmailPassword(email: email, password: password);
      return user;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      LocalDb db = LocalDb();
      UserModel? user = await db.getUser();

      if (user != null) {
        return user;
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      LocalDb db = LocalDb();
      await db.deleteUser();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
