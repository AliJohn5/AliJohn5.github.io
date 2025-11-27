import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorageService {

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  Future<void> writeSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearSecureData() async {
    await _secureStorage.deleteAll();
  }
}