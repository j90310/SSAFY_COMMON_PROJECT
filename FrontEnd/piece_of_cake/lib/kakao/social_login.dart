import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

abstract class SocialLogin {
  Future<bool> login();
  Future<bool> logout();
  Future<User> me();
}