import 'package:login_template/auth/services/secure_storage_service.dart';

Future<bool> isUserLoggedIn() async {
  final storageService = SecureStorageService();
  String? token = await storageService.readSecureData('refresh_token');
  return token != null;
}

Future<Map<String, String>> signInUser(String username, String password) async {
  await Future.delayed(const Duration(seconds: 3));

  final storageService = SecureStorageService();

  final userReal = await storageService.readSecureData("username");
  final passwordReal = await storageService.readSecureData("password");

  if (username != userReal || password != passwordReal) {
    return {'status': 'failed', 'message': 'username or password incorrect.'};
  }

  await storageService.writeSecureData(
    'access_token',
    'simulated_access_token',
  );
  await storageService.writeSecureData(
    'refresh_token',
    'simulated_refresh_token',
  );

  return {'status': 'success', 'message': 'User logged in successfully'};
}

Future<Map<String, String>> signUpUser(String username, String password) async {
  await Future.delayed(const Duration(seconds: 3));

  final storageService = SecureStorageService();
  await storageService.writeSecureData('username', username);
  await storageService.writeSecureData('password', password);

  return {'status': 'success', 'message': 'User created successfully'};
}

Future<Map<String, String>> refreshUser() async {
  await Future.delayed(const Duration(seconds: 3));
  final storageService = SecureStorageService();
  await storageService.writeSecureData(
    'access_token',
    'simulated_refreshed_access_token',
  );

  return {'status': 'success', 'message': 'User refreshed successfully'};
}

Future<Map<String, String>> forgetPassword(String username) async {
  await Future.delayed(const Duration(seconds: 3));
  return {'status': 'success', 'message': 'Your code is 123'};
}

Future<Map<String, String>> changePassword(
  String username,
  String password,
  String code,
) async {
  await Future.delayed(const Duration(seconds: 3));

  if (code != "123") {
    return {
      'status': 'failed',
      'message': 'Your code was wrong, please cheak your email.',
    };
  }

  final storageService = SecureStorageService();
  await storageService.writeSecureData('password', password);
  return {'status': 'success', 'message': 'password changed successfully'};
}
