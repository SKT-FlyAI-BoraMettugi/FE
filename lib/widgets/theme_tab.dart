import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/space_theme.dart';

class ThemeTab extends StatefulWidget {
  const ThemeTab({super.key});

  @override
  State<ThemeTab> createState() => _ThemeTabState();
}

class _ThemeTabState extends State<ThemeTab> {
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
              child: Padding(
                padding: EdgeInsets.only(
                  left: 25.w,
                  top: 122.h,
                ),
                child: Text(
                  "오늘은 어디로 떠나볼까요?",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
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
                          60.w,
                          60.h,
                        ),
                        painter: CirclePainter(
                          radius: 30.w,
                          color: Color(0xFF8C7B89),
                          centerX: 30.w,
                          centerY: 30.h,
                        ),
                      ),
                      Positioned(
                        left: 12.w,
                        top: 11.h,
                        child: Image.asset(
                          'assets/theme/spaceship.png',
                          width: 36.w,
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
                    children: [
                      Text(
                        "우주 월드",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "신비로운 우주를",
                        style: TextStyle(
                          color: Color(0xFF6F6D6D),
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        "탐험할 준비가 되었나요?",
                        style: TextStyle(
                          color: Color(0xFF6F6D6D),
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80.w,
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
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 24.w,
                      color: Color(0xFFA6A6A6),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
