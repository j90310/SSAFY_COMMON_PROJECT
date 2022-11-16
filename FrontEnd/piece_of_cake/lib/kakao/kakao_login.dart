
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:piece_of_cake/kakao/social_login.dart';

class KakaoLogin implements SocialLogin {

  @override
  Future<bool> login() async {
    if (await AuthApi.instance.hasToken()) {
      try {
        AccessTokenInfo tokenInfo =
        await UserApi.instance.accessTokenInfo();
        print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
        return true;
      } catch (error) {
        if (error is KakaoException && error.isInvalidTokenError()) {
          print('토큰 만료 $error');
        } else {
          print('토큰 정보 조회 실패 $error');
        }

        if (await isKakaoTalkInstalled()) {
          try {
            await UserApi.instance.loginWithKakaoTalk();
            print('카카오톡으로 로그인 성공');
            return true;
          } catch (error) {
            print('카카오톡으로 로그인 실패 $error');

            // // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
            // // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
            // if (error is PlatformException && error.code == 'CANCELED') {
            //   return;
            // }
            // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
            try {
              await UserApi.instance.loginWithKakaoAccount();
              print('카카오계정으로 로그인 성공');
              return true;
            } catch (error) {
              print('카카오계정으로 로그인 실패 $error');
              return false;
            }
          }
        } else {
          try {
            await UserApi.instance.loginWithKakaoAccount();
            print('카카오계정으로 로그인 성공');
            return true;
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
            return false;
          }
        }
      }
    } else {
      print('발급된 토큰 없음');
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('로그인 성공 ${token.accessToken}');
        return true;
      } catch (error) {
        print('로그인 실패 $error');
        return false;
      }
    }
  }

  // @override
  // Future<bool> login() async{
  //   try {
  //     bool isInstalled = await isKakaoTalkInstalled();
  //     if (isInstalled) {
  //       try {
  //         await UserApi.instance.loginWithKakaoTalk();
  //         return true;
  //       } catch (e) {
  //         return false;
  //       }
  //     } else {
  //       try {
  //         await UserApi.instance.loginWithKakaoAccount();
  //         return true;
  //       } catch (e) {
  //         return false;
  //       }
  //     }
  //   } catch(e) {
  //     return false;
  //   }
  // }

  @override
  Future<bool> logout() async{
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<User> me() async {
    User user = await UserApi.instance.me();
    return user;
    // try {
    //   User user = await UserApi.instance.me();
    //   print('사용자 정보 요청 성공'
    //       '\n회원번호: ${user.id}'
    //       '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
    //       '\n이메일: ${user.kakaoAccount?.email}');
    //   return user;
    // } catch (e) {
    //   print('사용자 정보 요청 실패 $e');
    //   return null;
    // }
  }

}