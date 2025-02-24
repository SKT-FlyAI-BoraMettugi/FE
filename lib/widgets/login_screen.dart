import 'dart:convert';

import 'package:FE/main.dart';
import 'package:FE/widgets/geturl_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String url;

  Future<String> kakaourl() async {
    final response = await http.get(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/user/auth/kakao/login-url'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> urls = jsonDecode(response.body);
      final GeturlModel url = GeturlModel.fromJson(urls);
      return url.login_url[0];
    }
    throw Error();
  }

  void fetchurl() async {
    final futureurl = await kakaourl();
    setState(() {
      url = futureurl;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchurl();
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
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
