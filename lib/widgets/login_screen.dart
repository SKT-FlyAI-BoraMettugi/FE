import 'dart:convert';

import 'package:FE/main.dart';
import 'package:FE/widgets/getloginstat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User? user;
  GetloginstatModel? stat;

  Future<GetloginstatModel> loginstat(
      String nickname, int kakaoId, String profileImg) async {
    final response = await http.patch(
      Uri.parse('http://nolly.ap-northeast-2.elasticbeanstalk.com/user/login'),
      body: utf8.encode(
        jsonEncode(
          {
            "nickname": nickname,
            "profile_img": profileImg,
            "kakao_id": kakaoId,
          },
        ),
      ),
    );
    if (response.statusCode == 200) {
      final String decodedbody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> stats = jsonDecode(decodedbody);
      final GetloginstatModel stat = GetloginstatModel.fromJson(stats);
      return stat;
    }
    throw Error();
  }

  void loginkakao() async {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
    try {
      user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user!.id}'
          '\n닉네임: ${user!.kakaoAccount?.profile?.nickname}'
          '\n프로필 사진: ${user!.kakaoAccount?.profile?.profileImageUrl}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
      return;
    }
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      print('토큰 정보 보기 성공'
          '\n회원정보: ${tokenInfo.id}'
          '\n만료시간: ${tokenInfo.expiresIn} 초');
    } catch (error) {
      print('토큰 정보 보기 실패 $error');
    }
    if (user != null) {
      try {
        stat = await loginstat(
          user!.kakaoAccount!.profile!.nickname!,
          user!.id,
          user!.kakaoAccount!.profile!.profileImageUrl!,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
              userId: stat!.user_id,
            ),
          ),
        );
      } catch (error) {
        print('유저 정보 불러오기 실패');
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            home: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.immersiveSticky);
              },
              child: Scaffold(
                backgroundColor: Color(0xFFEEEDF1),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 30.h,
                            fontFamily: 'SUITE',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        loginkakao();
                      },
                      child: Image.asset(
                        'assets/login/kakao_login_large_narrow.png',
                        width: 200.w,
                        height: 40.h,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
