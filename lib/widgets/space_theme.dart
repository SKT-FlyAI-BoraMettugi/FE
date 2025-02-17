import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/problem_screen.dart';

class SpaceTheme extends StatefulWidget {
  const SpaceTheme({super.key});

  @override
  State<SpaceTheme> createState() => _SpaceThemeState();
}

class _SpaceThemeState extends State<SpaceTheme> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF281C26),
        body: Column(
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
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 299.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()),
                    );
                  },
                  child: Icon(
                    Icons.notifications_none,
                    size: 24.w,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 19.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "우주 월드",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                width: 383.w,
                height: 1.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProblemScreen(),
                  ),
                );
              },
              child: CustomPaint(
                size: Size(60.w, 60.h),
                painter: CirclePainter(
                  radius: 30.w,
                  color: Color(0xFFCCF939).withValues(alpha: 0.3),
                  centerX: 30.w,
                  centerY: 30.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
