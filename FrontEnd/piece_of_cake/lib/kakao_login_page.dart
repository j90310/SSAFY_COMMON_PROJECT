import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:piece_of_cake/models/palette.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;

import 'main.dart';
import 'models/kakao_login_model.dart';

class KakaoLoginPage extends StatefulWidget {
  const KakaoLoginPage({Key? key}) : super(key: key);

  @override
  State<KakaoLoginPage> createState() => _KakaoLoginPageState();
}

class _KakaoLoginPageState extends State<KakaoLoginPage> {
  final _database = FirebaseFirestore.instance;
  // kakao.User? user;
  @override
  Widget build(BuildContext context) {
    var kakaoUserProvider = Provider.of<KakaoLoginModel>(context);
    var palette = Provider.of<Palette>(context);

    // void _loginFirebase() async{
    //   String? uid = "kakao:" + user!.id.toString();
    //   _database.collection('users').doc(uid).set({
    //     //'uid': user!.id.toString(),
    //     'uid': '1',
    //     //'username': user!.kakaoAccount!.profile!.nickname,
    //     'test':'test'
    //   }, SetOptions(merge: true));
    // }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Kakao Login Page'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // height: 50,
            ),
            Image.asset('assets/images/logo_transparent.png'),
            // SizedBox(
            //   child: Text(
            //     'Piece\nOf\nCake',
            //     style: TextStyle(
            //       fontSize: 50,
            //       fontWeight: FontWeight.w900,
            //       color: palette.createMaterialColor(Color(0xff764624)),
            //     ),
            //   ),
            // ),
            SizedBox(
              // height: 150,
              // height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                // await KakaoLoginModel().setUser();
                await Provider.of<KakaoLoginModel>(context, listen: false).setKakaoLoginUser();
                print('login');
                print('user: ${Provider.of<KakaoLoginModel>(context, listen: false).user}');
                Route route = MaterialPageRoute(builder: (context) => const MainPage());
                Navigator.pushReplacement(context, route);

                sleep(const Duration(seconds:1));

                // String? uid = "kakao:" + user!.id.toString();
                String? uid = "kakao:" + kakaoUserProvider.user!.id.toString();
                await _database.collection('users').doc(uid).set({
                  'uid': kakaoUserProvider.user!.id.toString(),
                  'username': kakaoUserProvider.user!.kakaoAccount!.profile!.nickname,
                  'userProfileImageUrl': kakaoUserProvider.user!.kakaoAccount!.profile!.profileImageUrl,
                }, SetOptions(merge: true));
              },
              style: ElevatedButton.styleFrom(
                primary: palette.createMaterialColor(Color(0xffFFE400)),
                side: BorderSide(width: 2, color: palette.createMaterialColor(Color(0xff3F1D1D))),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              ),
              child: Text(
                '카카오 로그인',
                style: TextStyle(
                  color: palette.createMaterialColor(Color(0xff3F1D1D)),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: palette.createMaterialColor(Color(0xffF9F1BF)),
    );
  }
}
