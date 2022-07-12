import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys{
  static const accessToken = 'access-token';
  static const refreshToken = 'refresh-token';

}


class Session {
  static const _secureStorage = FlutterSecureStorage();
  Future<void> setAccessToken(String value) =>
       _secureStorage.write(key: _Keys.accessToken, value: value);
  Future<String?> getAccessToken() => _secureStorage.read(key: _Keys.accessToken);
  
  Future<void> setRefreshToken(String value) =>
       _secureStorage.write(key: _Keys.refreshToken, value: value);
  Future<String?> getRefreshToken() => _secureStorage.read(key: _Keys.refreshToken);      
}


class SessionState {
  final token_data = Session();
}