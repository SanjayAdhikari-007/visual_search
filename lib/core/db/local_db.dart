import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/data/models/user_model.dart';

class LocalDb {
  final _storage = FlutterSecureStorage(
      aOptions: const AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  final String _emailKey = "USER_EMAIL";
  final String _nameKey = "USER_NAME";
  final String _idKey = "USER_ID";
  final String _tokenKey = "USER_TOKEN";

  // Save user to local DB.
  Future<void> saveUser(UserModel user, String token) async {
    await _storage.write(key: _emailKey, value: user.email);
    await _storage.write(key: _nameKey, value: user.name);
    await _storage.write(key: _idKey, value: user.id);
    await _storage.write(key: _tokenKey, value: token);
  }

  // Fetches User from Local DB.
  Future<UserModel?> getUser() async {
    String? email = await _storage.read(key: _emailKey);
    String? id = await _storage.read(key: _idKey);
    String? name = await _storage.read(key: _nameKey);

    if (email != null && id != null && name != null) {
      return UserModel(id: id, email: email, name: name);
    }

    return null;
  }

  // Fetches User Token from Local DB.
  Future<String?> getToken() async {
    String? token = await _storage.read(key: _tokenKey);
    return token;
  }

  // Delete User from Local DB.
  Future<void> deleteUser() async {
    await _storage.delete(key: _emailKey);
    await _storage.delete(key: _idKey);
    await _storage.delete(key: _nameKey);
    await _storage.delete(key: _tokenKey);
  }
}
