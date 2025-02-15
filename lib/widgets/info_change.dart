import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/circle_painter.dart';

class InfoChange extends StatelessWidget {
  const InfoChange({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                          Icons.arrow_back_ios,
                          size: 24.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  Stack(
                    children: [
                      CustomPaint(
                        size: Size(393.w, 60.h),
                        painter: CirclePainter(
                          radius: 30.w,
                          color: Color(0xFFD9D9D9),
                          centerX: 197.w,
                          centerY: 30.h,
                        ),
                      ),
                      Positioned(
                        left: 173.w,
                        top: 9.h,
                        child: Image.asset(
                          'assets/main/rabbit.png',
                          width: 48.w,
                          height: 48.h,
                        ),
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
                          vertical: 17.h,
                        ),
                        child: Text(
                          "이름",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 101.w,
                      ),
                      Text(
                        "이동현",
                        style: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 23.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 17.h,
                        ),
                        child: Text(
                          "생년월일",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 69.w,
                      ),
                      Text(
                        "99.09.28",
                        style: TextStyle(
                          fontSize: 17.sp,
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
                          vertical: 17.h,
                        ),
                        child: Text(
                          "휴대폰 번호",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 48.w,
                      ),
                      Text(
                        "010-1234-1234",
                        style: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
