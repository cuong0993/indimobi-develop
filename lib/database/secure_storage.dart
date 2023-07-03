// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class SecureStorageHelper {
//   static const apiTokenKey = 'apiTokenKey';
//
//   final FlutterSecureStorage storage;
//
//   SecureStorageHelper._(this.storage);
//
//   static final SecureStorageHelper _instance =
//       SecureStorageHelper._(const FlutterSecureStorage());
//
//   static SecureStorageHelper get instance => _instance;
//
//   // //Save token
//   // void saveToken(TokenEntity token) async {
//   //   await storage.write(key: apiTokenKey, value: jsonEncode(token.toJson()));
//   //   //SharedPreferencesHelper.setApiTokenKey(apiTokenKey);
//   // }
//
//   //Remove token
//   void removeToken() async {
//     await storage.delete(key: apiTokenKey);
//     // SharedPreferencesHelper.removeApiTokenKey();
//   }
//
//   // //Get token
//   // //Future<TokenEntity?> getToken() async {
//   //   try {
//   //    // final key = await SharedPreferencesHelper.getApiTokenKey();
//   //     final tokenEncoded = await storage.read(key: key);
//   //     if (tokenEncoded == null) {
//   //       return null;
//   //     } else {
//   //     //  return TokenEntity.fromJson(
//   //     //      jsonDecode(tokenEncoded) as Map<String, dynamic>);
//   //     }
//   //   } catch (e) {
//   //     return null;
//   //   }
//   // }
// }
