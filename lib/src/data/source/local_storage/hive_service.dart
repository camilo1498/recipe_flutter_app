import 'package:hive/hive.dart';
import 'package:receipt_app/src/data/models/user/user_model.dart';

class HiveService {
  /// instances
  final Box _localStorage = Hive.box('local_storage');

  /// get user profile
  UserModel? get profile {
    final res = _localStorage.get("user_profile", defaultValue: null);
    return res != null ? UserModel.fromRawJson(res) : null;
  }

  /// save user profile
  set profile(UserModel? val) => _localStorage.put(
        "user_profile",
        val?.toRawJson(),
      );

  /// token
  String get token => _localStorage.get('token') ?? '';
  set token(String? token) => _localStorage.put('token', token);

  /// refresh token
  String get refreshToken => _localStorage.get('refreshToken') ?? '';
  set refreshToken(String? refreshToken) =>
      _localStorage.put('refreshToken', refreshToken);

  /// clean hive local storage
  logout() async {
    await _localStorage.delete('token');
    await _localStorage.delete('refreshToken');
    await _localStorage.delete('user_profile');
    await _localStorage.deleteAll(_localStorage.keys);
  }
}
