import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys{
  static const accessToken = 'access-token';
}


class Session {
  static const _secureStorage = FlutterSecureStorage();
  Future<void> setAccessToken(String value) =>
       _secureStorage.write(key: _Keys.accessToken, value: value);
  Future<String?> getAccessToken() => _secureStorage.read(key: _Keys.accessToken);     
}


class SessionState {
  final token_data = Session();
}