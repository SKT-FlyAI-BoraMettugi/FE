import 'package:FE/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController id = TextEditingController();
  final TextEditingController pw = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    id.clear();
    pw.clear();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 240.h,
                          height: 140.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9F8FF),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.h,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: id,
                                    showCursor: true,
                                    style: TextStyle(
                                      fontSize: 15.h,
                                      fontFamily: 'SUITE',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "아이디",
                                        hintStyle: TextStyle(
                                          fontSize: 15.h,
                                          fontFamily: 'SUITE',
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFA6A6A6),
                                        )),
                                  ),
                                  TextField(
                                    controller: pw,
                                    showCursor: true,
                                    style: TextStyle(
                                      fontSize: 15.h,
                                      fontFamily: 'SUITE',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "비밀번호",
                                        hintStyle: TextStyle(
                                          fontSize: 15.h,
                                          fontFamily: 'SUITE',
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFA6A6A6),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                            );
                            id.clear();
                            pw.clear();
                          },
                          child: Container(
                            width: 120.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "로그인",
                                  style: TextStyle(
                                    fontSize: 20.h,
                                    fontFamily: 'SUITE',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
