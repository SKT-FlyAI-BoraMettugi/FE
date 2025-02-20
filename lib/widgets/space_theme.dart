import 'package:FE/widgets/notification_screen.dart';
import 'package:FE/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/problem_screen.dart';

class SpaceTheme extends StatefulWidget {
  const SpaceTheme({super.key});

  @override
  State<SpaceTheme> createState() => _SpaceThemeState();
}

class _SpaceThemeState extends State<SpaceTheme> {
  bool isCleared = false;

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
                    size: 24.h,
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
                    size: 24.h,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 17.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "우주 월드",
                  style: TextStyle(
                    fontSize: 20.h,
                    fontFamily: 'SUITE',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                width: 383.w,
                height: 1.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Container(
              width: 393.w,
              height: 650.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 53.h,
                    left: 54.w,
                    child: Image.asset(
                      'assets/theme/earth.png',
                      width: 55.h,
                      height: 55.h,
                    ),
                  ),
                  Positioned(
                    top: 396.h,
                    left: 250.w,
                    child: Image.asset(
                      'assets/theme/falling_star.png',
                      width: 112.h,
                      height: 112.h,
                    ),
                  ),
                  Positioned(
                    top: 661.h,
                    left: 103.w,
                    child: Transform.scale(
                      scale: 2,
                      child: Transform.rotate(
                        angle: (360 - 138.31) * pi / 180,
                        child: Image.asset(
                          'assets/theme/moon.png',
                          width: 256.h,
                          height: 256.h,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 527.h,
                    left: 99.w,
                    child: Image.asset(
                      'assets/theme/telescope.png',
                      width: 63.h,
                      height: 63.h,
                    ),
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 150.w,
                    ypos: 147.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 206.w,
                    ypos: 147.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 262.w,
                    ypos: 147.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 150.w,
                    ypos: 222.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 206.w,
                    ypos: 222.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 262.w,
                    ypos: 222.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 76.w,
                    ypos: 333.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 132.w,
                    ypos: 333.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 188.w,
                    ypos: 333.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 76.w,
                    ypos: 408.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 132.w,
                    ypos: 408.h,
                    isCleared: isCleared,
                  ),
                  ThemeButton(
                    colorCleared: Color(0xFFCCF939),
                    colorUnCleared: Color(0xFF595F2C),
                    xpos: 188.w,
                    ypos: 408.h,
                    isCleared: isCleared,
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
