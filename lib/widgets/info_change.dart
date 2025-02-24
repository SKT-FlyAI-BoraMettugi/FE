import 'dart:convert';

import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/circle_painter.dart';
import 'package:http/http.dart' as http;

class InfoChange extends StatefulWidget {
  String nickname;
  InfoChange({
    super.key,
    required this.nickname,
  });

  @override
  State<InfoChange> createState() => _InfoChangeState();
}

class _InfoChangeState extends State<InfoChange> {
  TextEditingController name = TextEditingController();

  Future<void> modifyname() async {
    final response = await http.patch(
        Uri.parse(
            'http://nolly.ap-northeast-2.elasticbeanstalk.com/user/nickname/1'),
        body: utf8.encode(jsonEncode({"user_id": 1, "nickname": name.text})));
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEDF1),
      body: Column(
        children: [
          Container(
            width: 393.w,
            height: 355.h,
            decoration: BoxDecoration(
              color: Color(0xFFF9F9FF),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 35.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 23.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 24.h,
                      ),
                    ),
                    SizedBox(
                      width: 323.w - 24.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                      },
                      child: Icon(
                        Icons.notifications_none,
                        size: 24.h,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 34.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CustomPaint(
                          size: Size(60.h, 60.h),
                          painter: CirclePainter(
                            radius: 30.h,
                            color: Color(0xFFD9D9D9),
                            centerX: 30.h,
                            centerY: 30.h,
                          ),
                        ),
                        Positioned(
                          left: 6.h,
                          top: 6.h,
                          child: Image.asset(
                            'assets/main/rabbit.png',
                            width: 48.h,
                            height: 48.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 17.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 23.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                      ),
                      child: Text(
                        "닉네임",
                        style: TextStyle(
                          fontSize: 20.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 89.w,
                    ),
                    Stack(children: [
                      SizedBox(
                        width: 130.w,
                      ),
                      Text(
                        widget.nickname,
                        style: TextStyle(
                          fontSize: 20.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "닉네임 변경",
                                  style: TextStyle(
                                    fontSize: 20.h,
                                    fontFamily: 'SUITE',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                content: TextField(
                                  controller: name,
                                  showCursor: true,
                                  style: TextStyle(
                                    fontSize: 15.h,
                                    fontFamily: 'SUITE',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "변경할 닉네임을 입력해주세요.",
                                    hintStyle: TextStyle(
                                      fontSize: 15.h,
                                      fontFamily: 'SUITE',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFA6A6A6),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      FocusScope.of(context).unfocus();
                                      SystemChrome.setEnabledSystemUIMode(
                                          SystemUiMode.immersiveSticky);
                                    }, // 취소 버튼
                                    child: Text(
                                      "취소",
                                      style: TextStyle(
                                        fontSize: 15.h,
                                        fontFamily: 'SUITE',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      modifyname();
                                      name.clear();
                                      Navigator.pop(context);
                                      FocusScope.of(context).unfocus();
                                      SystemChrome.setEnabledSystemUIMode(
                                          SystemUiMode.immersiveSticky);
                                    },
                                    child: Text(
                                      "변경",
                                      style: TextStyle(
                                        fontSize: 15.h,
                                        fontFamily: 'SUITE',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Text(
                        "닉네임 변경",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 23.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                      ),
                      child: Text(
                        "생년월일",
                        style: TextStyle(
                          fontSize: 20.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 76.w,
                    ),
                    Text(
                      "99.09.28",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 23.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                      ),
                      child: Text(
                        "휴대폰 번호",
                        style: TextStyle(
                          fontSize: 20.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Text(
                      "010-1234-1234",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
