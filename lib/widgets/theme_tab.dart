import 'dart:convert';

import 'package:FE/widgets/notification_screen.dart';
import 'package:FE/widgets/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/space_theme.dart';
import 'package:http/http.dart' as http;

class ThemeTab extends StatefulWidget {
  const ThemeTab({super.key});

  @override
  State<ThemeTab> createState() => _ThemeTabState();
}

class _ThemeTabState extends State<ThemeTab> {
  Future<void> getThemeList(userId) async {
    final response =
        await http.get(Uri.parse('http://boramettugi.com/user/login/$userId'));

    var themes = jsonDecode(response.body);
    for (var theme in themes) {
      final thema = ThemeModel.fromJson(theme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFEEEDF1),
        body: Column(
          children: [
            Container(
              width: 393.w,
              height: 192.h,
              decoration: BoxDecoration(
                color: Color(0xFFF9F8FF),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 35.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 346.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.notifications_none,
                          size: 24.h,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 63.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "오늘은 어디로 떠나볼까요?",
                        style: TextStyle(
                          fontSize: 30.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpaceTheme(),
                  ),
                );
              },
              child: Container(
                width: 393.w,
                height: 76.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF9F8FF),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 25.w,
                    ),
                    Stack(
                      children: [
                        CustomPaint(
                          size: Size(
                            60.h,
                            60.h,
                          ),
                          painter: CirclePainter(
                            radius: 30.h,
                            color: Color(0xFF8C7B89),
                            centerX: 30.h,
                            centerY: 30.h,
                          ),
                        ),
                        Positioned(
                          left: 12.h,
                          top: 11.h,
                          child: Image.asset(
                            'assets/theme/spaceship.png',
                            width: 36.h,
                            height: 36.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 21.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 9.h,
                        ),
                        Text(
                          "우주 월드",
                          style: TextStyle(
                            fontSize: 17.h,
                            fontFamily: 'SUITE',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "신비로운 우주를\n탐험할 준비가 되었나요?",
                          style: TextStyle(
                              color: Color(0xFF6F6D6D),
                              fontFamily: 'SUITE',
                              fontSize: 15.h,
                              fontWeight: FontWeight.w400,
                              height: 1),
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 120.w,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 24.h,
                      color: Color(0xFFA6A6A6),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
