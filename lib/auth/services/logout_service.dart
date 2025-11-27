import 'package:login_template/auth/services/secure_storage_service.dart';

Future<void> logoutUser() async {
  final storageService = SecureStorageService();
  await storageService.deleteSecureData("access_token");
  await storageService.deleteSecureData("refresh_token");
}
