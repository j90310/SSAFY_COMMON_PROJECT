import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:piece_of_cake/kakao/social_login.dart';

import '../../kakao/kakao_login.dart';
import '../vo.dart';

class KakaoLoginModel with ChangeNotifier {
  SocialLogin _socialLogin = KakaoLogin();
  bool isLoggedIn = false;
  User? _user;
  User? get user => _user;
  UserResVO? _userResVO;  // _userResVO.userSeq
  UserResVO? get userResVO => _userResVO;
  UserResVO? _currentPartyWriter;
  UserResVO? get currentPartyWriter => _currentPartyWriter;

  void setUser(UserResVO userResVO) {
    _userResVO = userResVO;
    notifyListeners();
  }

  Future setKakaoLoginUser() async {
    var keyHash = await KakaoSdk.origin;
    print('keyHash: ${keyHash}');
    isLoggedIn = await _socialLogin.login();
    if (isLoggedIn) {
      this._user = await UserApi.instance.me();
      UserReqVO userReqVO = new UserReqVO(
        userEmail: this._user!.kakaoAccount!.email.toString(),
        userPhone: this._user!.kakaoAccount!.phoneNumber.toString(),
        userNickname: this._user!.kakaoAccount!.profile!.nickname.toString(),
        userImage: this._user!.kakaoAccount!.profile!.profileImageUrl.toString(),
        userKakaoLoginId: this._user?.id.toString(),
        userRating: 50,
      );
      final response = await http.post(
        // Uri.parse('http://localhost:9090/kakao-login'),
        Uri.parse('http://i7e203.p.ssafy.io:9090/kakao-login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userReqVO),
      );
      if (response.statusCode==200) {
        // this._userResVO = UserResVO.fromJson(jsonDecode(response.body));
        this._userResVO = UserResVO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        // print('login post req 200');
        // print(jsonDecode(response.body));
      }else {
        // print('response.statusCode: ${response.statusCode}');
      }
    }
    // print('kakao login model');
    // print('_user: ${_user}');
    // print('_userResVO: ${_userResVO}');
    // notifyListeners();
  }

  Future setCurrentPartyWriter(int userSeq) async {
    // print('[KakaoLoginModel] setCurrentPartyWriter(int userSeq) called');
    final response = await http.get(
        Uri.parse('http://i7e203.p.ssafy.io:9090/user/${userSeq}')
    );
    if (response.statusCode==200){
      UserResVO userResVO = UserResVO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      _currentPartyWriter = userResVO;
      // print('${_currentPartyWriter!.userNickname}');
    } else {
      throw Exception('Failed to load current party writer.');
    }
  }

  Future logOut() async {
    await _socialLogin.logout();
    isLoggedIn = false;
    _user = null;
    notifyListeners();
  }
}
