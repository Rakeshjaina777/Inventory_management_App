// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:healthgini/src/core/storage/storage_keys.dart';
//
// class SecureStorage {
//   static const _storage = FlutterSecureStorage();
//
//   static Future<void> saveToken(String token) async {
//     await _storage.write(key: StorageKeys.authTokenKey, value: token);
//   }
//
//   static Future<String?> getToken() async {
//     return await _storage.read(key: StorageKeys.authTokenKey);
//   }
//
//   static Future<void> logout() async {
//     await _storage.delete(key: StorageKeys.authTokenKey);
//   }
// }
